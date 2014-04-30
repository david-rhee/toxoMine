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
 * ID resolver for Ensemble and other genes
 *
 * @author David Rhee
 */
public class BioMartCustomIdentifiersResolverFactory extends IdResolverFactory
{
    protected static final Logger LOG = Logger.getLogger(BioMartCustomIdentifiersResolverFactory.class);

    // data file path set in ~/.intermine/MINE.properties
    private final String propKey = "resolver.file.rootpath";
    
    private final String resolverFileSymboFlyBase = "biomartflybase";
    private final String resolverFileSymboHuman = "biomarthuman";
    private final String resolverFileSymboMGI = "biomartmgi";
    private final String resolverFileSymboRGD = "biomartrgd";
    private final String resolverFileSymboToxo = "toxoplasmagondii";
    
    /**
     * Construct without SO term of the feature type.
     * @param soTerm the feature type to resolve
     */
    public BioMartCustomIdentifiersResolverFactory() {
        this.clsCol = this.defaultClsCol;
    }

    /**
     * Construct with SO term of the feature type.
     * @param soTerm the feature type to resolve
     */
    public BioMartCustomIdentifiersResolverFactory(String clsName) {
        this.clsCol = new HashSet<String>(Arrays.asList(new String[] {clsName}));
    }

    /**
     * Build an IdResolver from each files
     * @return an IdResolver for Ensemble and other genes
     */
    @Override
    protected void createIdResolver() {
        if (resolver != null && resolver.hasClassName(this.clsCol.iterator().next())) {
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
        	if (!isCachedIdResolverRestored || (isCachedIdResolverRestored && !resolver.hasClassName(this.clsCol.iterator().next()))) {
            	
                String resolverFileRoot = PropertiesUtil.getProperties().getProperty(propKey);

                if (StringUtils.isBlank(resolverFileRoot)) {
                    String message = "Resolver data file root path is not specified";
                    LOG.warn(message);
                    return;
                }

                LOG.info("Creating id resolver from data files and caching it.");
                
                // FlyBase
                String resolverFileNameFlyBase = resolverFileRoot.trim() + resolverFileSymboFlyBase;
                File fileFlyBase = new File(resolverFileNameFlyBase);
                if (fileFlyBase.exists()) {
                    createFromFile(fileFlyBase, "7227");
                    resolver.writeToFile(new File(ID_RESOLVER_CACHED_FILE_NAME));
                } else {
                    LOG.warn("Resolver file not exists: " + resolverFileNameFlyBase);
                }
                
                // Human
                String resolverFileNameHuman = resolverFileRoot.trim() + resolverFileSymboHuman;
                File fileHuman = new File(resolverFileNameHuman);
                if (fileHuman.exists()) {
                    createFromFile(fileHuman, "9606");
                    resolver.writeToFile(new File(ID_RESOLVER_CACHED_FILE_NAME));
                } else {
                    LOG.warn("Resolver file not exists: " + resolverFileNameHuman);
                }                

                // Mouse
                String resolverFileNameMGI = resolverFileRoot.trim() + resolverFileSymboMGI;
                File fileMGI = new File(resolverFileNameMGI);
                if (fileMGI.exists()) {
                    createFromFile(fileMGI, "10090");
                    resolver.writeToFile(new File(ID_RESOLVER_CACHED_FILE_NAME));
                } else {
                    LOG.warn("Resolver file not exists: " + resolverFileNameMGI);
                }  

                // Rat
                String resolverFileNameRGD = resolverFileRoot.trim() + resolverFileSymboRGD;
                File fileRGD = new File(resolverFileNameRGD);
                if (fileRGD.exists()) {
                    createFromFile(fileRGD, "10116");
                    resolver.writeToFile(new File(ID_RESOLVER_CACHED_FILE_NAME));
                } else {
                    LOG.warn("Resolver file not exists: " + resolverFileNameRGD);
                }  

                // Toxo
                String resolverFileNameToxo = resolverFileRoot.trim() + resolverFileSymboToxo;
                File fileToxo = new File(resolverFileNameToxo);
                if (fileToxo.exists()) {
                    createFromFile(fileToxo, "5811");
                    resolver.writeToFile(new File(ID_RESOLVER_CACHED_FILE_NAME));
                } else {
                    LOG.warn("Resolver file not exists: " + resolverFileNameToxo);
                }  
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    protected void createFromFile(File f, String taxonId) throws IOException {
        // data is in format:
        // ...
        Iterator<?> lineIter = FormattedTextParser.parseTabDelimitedReader(new BufferedReader(new FileReader(f)));
        while (lineIter.hasNext()) {	
            String[] line = (String[]) lineIter.next();

            if (line.length < 2) {
                continue;
            }

            String mainId = line[0];
            String[] synonyms = new String[(line.length - 1)];
            for (int x = 1; x < line.length; x++) {
            	synonyms[x-1] = line[x];
            }
            //LOG.info("Adding main id: " + mainId + " with taxonId: " + taxonId);
            resolver.addMainIds(taxonId, mainId, Collections.singleton(mainId));
            resolver.addSynonyms(taxonId, mainId, new HashSet<String>(Arrays.asList(synonyms)));
        }
    }
}
