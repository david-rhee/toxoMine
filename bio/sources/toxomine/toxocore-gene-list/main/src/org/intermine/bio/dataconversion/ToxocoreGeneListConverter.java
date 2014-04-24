package org.intermine.bio.dataconversion;

/*
 * Copyright (C) 2013-2015 toxoMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */

import java.io.Reader;
import java.io.BufferedReader;
import java.io.IOException;

import java.util.Arrays;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

import org.apache.log4j.Logger;

import org.intermine.bio.dataconversion.IdResolver;
import org.intermine.bio.dataconversion.IdResolverService;
import org.intermine.dataconversion.ItemWriter;
import org.intermine.metadata.Model;
import org.intermine.objectstore.ObjectStoreException;
import org.intermine.util.StringUtil;
import org.intermine.xml.full.Item;

/**
 * 
 * @ David Rhee
 */
public class ToxocoreGeneListConverter extends BioFileConverter
{
    private static final String DATASET_TITLE = "Gene Lists";
    private static final String DATA_SOURCE_NAME = "toxoCORE.org";
    
    private static final Logger LOG = Logger.getLogger(ToxocoreGeneListConverter.class);
    private IdResolver rslv;

    /**
     *	Map to store gene and submission items which will allow to store only unique objects
     */
    private Map<String, Item> geneListMap = new LinkedHashMap<String, Item>();
    private Map<String, Item> geneMap = new LinkedHashMap<String, Item>();
    private Map<String, Item> submissionMap = new LinkedHashMap<String, Item>();
    
    /**
     * Constructor
     * @param writer the ItemWriter used to handle the resultant items
     * @param model the Model
     */
    public ToxocoreGeneListConverter(ItemWriter writer, Model model) {
        super(writer, model, DATA_SOURCE_NAME, DATASET_TITLE);
    }
    
    /**
     * Read lines from a BufferedReader and store items to database.
     * @param reader the Reader to reader from
     * @throws IOException if there is an error during reading or parsing
     */
    public void process(Reader reader) throws IOException, ObjectStoreException {
    	BufferedReader newReader = new BufferedReader(reader);
        String line = null;
        
        setUpResolver();

        while ((line = newReader.readLine()) != null) {
            String trimmedLine = line.trim();

            if (trimmedLine.length() == 0 || trimmedLine.startsWith("#")) {
                continue;
            }   
            processLine(trimmedLine);
        }
        //Store to DB
        for( Item gene : geneMap.values() ) {
        	store(gene);
        }
        for( Item submission : submissionMap.values() ) {
        	store(submission);
        }
        for( Item geneList : geneListMap.values() ) {
        	store(geneList);
        }
    }
    
    /**
     * Takes each line and process them accordingly
     */
    private void processLine(String line) throws ObjectStoreException {
    	String[] columns = line.split("\t");
    	
    	//Read each column
    	String geneID = columns[0].trim();
    	String readCount = columns[1].trim();
    	String geneListName = columns[2].trim();
    	String TCid = columns[3].trim();

    	//Resolve ID
    	String resolvedIdentifier = resolveGene("5811", geneID);
    	
    	//GeneList Item
    	Item geneListItem = createItem("GeneList");
    	geneListItem.setAttribute("name", geneListName);
    	geneListItem.setAttribute("readCount", readCount);
    	
    	//Get Items
    	Item geneItem = getGeneItem(resolvedIdentifier, geneListItem);
    	Item submissionItem = getSubmissionItem(TCid,geneListItem);
    	
    	//Set references
    	geneListItem.setReference("gene", geneItem);
    	geneListItem.setReference("submission", submissionItem);
    	
    	geneListMap.put(resolvedIdentifier, geneListItem);
    }
    
    private void setUpResolver() {
        if (rslv == null) {
        	rslv = IdResolverService.getToxoIdResolver();
        }
    }
    
    private String resolveGene(String taxonId, String identifier) {
        if (rslv == null) {
            // no id resolver available, so return the original identifier
        	LOG.info("RESOLVER: no id resolver available");
            return identifier;
        }
        if (!rslv.hasTaxon(taxonId)) {
            // no id resolver available, so return the original identifier
        	LOG.info("RESOLVER: no id resolver with " + taxonId + " available.");
            return identifier;
        }
        int resCount = rslv.countResolutions(taxonId, "gene", identifier);
        if (resCount != 1) {
            LOG.info("RESOLVER: failed to resolve gene to one identifier, ignoring gene: "
                     + identifier + " count: " + resCount + " Resolved: "
                     + rslv.resolveId(taxonId, identifier));
            return identifier;
        }
        LOG.info("resolved " + rslv.resolveId(taxonId, identifier).iterator().next());
        return rslv.resolveId(taxonId, identifier).iterator().next();
    }
 
    /**
     * 
     */
    private Item getGeneItem(String resolvedIdentifier, Item geneListItem) {
        if (geneMap.containsKey(resolvedIdentifier)) {
        	Item geneItem = geneMap.get(resolvedIdentifier);
        	geneItem.addToCollection("geneLists", geneListItem);
        	return geneItem;
        }
        
        Item geneItem = createItem("Gene");
        geneItem.setAttribute("primaryIdentifier", resolvedIdentifier);
        geneItem.addToCollection("geneLists", geneListItem);
        geneMap.put(resolvedIdentifier, geneItem);
        return geneItem;
    }
    
    /**
     * 
     */
    private Item getSubmissionItem(String TCid, Item geneListItem) {
        if (submissionMap.containsKey(TCid)) {
        	Item submissionItem = submissionMap.get(TCid);
        	submissionItem.addToCollection("geneLists", geneListItem);
        	submissionMap.put(TCid, submissionItem);
        	return submissionItem;
        }
        
        Item submissionItem = createItem("Submission");
        submissionItem.setAttribute("TCid", TCid);
        submissionItem.addToCollection("geneLists", geneListItem);
        submissionMap.put(TCid, submissionItem);
        return submissionItem;
    }
}
