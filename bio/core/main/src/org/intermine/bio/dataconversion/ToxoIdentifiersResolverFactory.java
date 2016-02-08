package org.intermine.bio.dataconversion;

/*
 * Copyright (C) 2014-2015 toxoMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.intermine.util.FormattedTextParser;
import org.intermine.util.PropertiesUtil;
import org.intermine.util.StringUtil;

/**
 * ID resolver for Toxoplasma genes
 *
 * @author David Rhee
 */
public class ToxoIdentifiersResolverFactory extends IdResolverFactory
{
    protected static final Logger LOG = Logger.getLogger(ToxoIdentifiersResolverFactory.class);

    // data file path set in ~/.intermine/MINE.properties
    private final String propKey = "resolver.file.rootpath";
    private final String resolverFileSymbo = "toxoplasmagondii";
    private final String taxonId = "5811";

    private static final String GENE_PATTERN_TG = "TG";
    
    /**
     * Construct without SO term of the feature type.
     * @param soTerm the feature type to resolve
     */
    public ToxoIdentifiersResolverFactory() {
        this.clsCol = this.defaultClsCol;
    }

    /**
     * Construct with SO term of the feature type.
     * @param soTerm the feature type to resolve
     */
    public ToxoIdentifiersResolverFactory(String clsName) {
        this.clsCol = new HashSet<String>(Arrays.asList(new String[] {clsName}));
    }

    /**
     * Build an IdResolver from Toxoplasma Gene toxoplasmagondii file
     * @return an IdResolver for Toxoplasma Gene
     */
    @Override
    protected void createIdResolver() {
        if (resolver != null && resolver.hasTaxonAndClassName(taxonId, this.clsCol.iterator().next())) {
            return;
        } else {
            if (resolver == null) {
                if (clsCol.size() > 1) {
                    resolver = new IdResolver();
                } else {
                    resolver = new IdResolver(clsCol.iterator().next());
                }
            }
        }

        try {
            boolean isCachedIdResolverRestored = restoreFromFile();
        	if (!isCachedIdResolverRestored || (isCachedIdResolverRestored && !resolver.hasTaxonAndClassName(taxonId, this.clsCol.iterator().next()))) {
            	
                String resolverFileRoot = PropertiesUtil.getProperties().getProperty(propKey);

                if (StringUtils.isBlank(resolverFileRoot)) {
                    String message = "Resolver data file root path is not specified";
                    LOG.warn(message);
                    return;
                }

                LOG.info("Creating id resolver from data file and caching it.");
                String resolverFileName = resolverFileRoot.trim() + resolverFileSymbo;
                File f = new File(resolverFileName);
                if (f.exists()) {
                    createFromFile(f);
                    resolver.writeToFile(new File(ID_RESOLVER_CACHED_FILE_NAME));
                } else {
                    LOG.warn("Resolver file not exists: " + resolverFileName);
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    protected void createFromFile(File f) throws IOException {
        // data is in format:
        // TG**	IDs...
        Iterator<?> lineIter = FormattedTextParser.parseTabDelimitedReader(new BufferedReader(new FileReader(f)));
        while (lineIter.hasNext()) {	
            String[] line = (String[]) lineIter.next();

            if (line.length < 2 || !line[0].startsWith(GENE_PATTERN_TG)) {
                continue;
            }

            String toxoId = line[0];
            String[] synonyms = new String[(line.length - 1)];
            for (int x = 1; x < line.length; x++) {
            	synonyms[x-1] = line[x];
            }
            resolver.addMainIds(taxonId, toxoId, Collections.singleton(toxoId));
            resolver.addSynonyms(taxonId, toxoId, new HashSet<String>(Arrays.asList(synonyms)));
        }
    }
}
