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
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import org.apache.commons.collections.keyvalue.MultiKey;
import org.apache.log4j.Logger;
import org.intermine.bio.dataconversion.IdResolverService;
import org.intermine.bio.util.OrganismData;
import org.intermine.dataconversion.ItemWriter;
import org.intermine.metadata.Model;
import org.intermine.objectstore.ObjectStoreException;
import org.intermine.util.StringUtil;
import org.intermine.xml.full.Item;

/**
 * modified from orthodbconverter/homologeneconverter
 * @author David Rhee
 */
public class OrthoMCLDBConverter extends BioFileConverter
{
    private static final String DATASET_TITLE = "OrthoMCLDB data set";
    private static final String DATA_SOURCE_NAME = "orthomcldb";
    private static final String PROP_FILE_MAIN = "orthomcldb_config.properties";
    private static final String PROP_FILE_ORGANISM_KEY = "orthomcldb-organism-key_config.properties";
    private static final String DEFAULT_IDENTIFIER_TYPE = "primaryIdentifier";
    private static final String ORTHOLOGUE = "orthologue";
    private static final String PARALOGUE = "paralogue";
    private static final String EVIDENCE_CODE_ABBR = "AA";
    private static final String EVIDENCE_CODE_NAME = "Amino acid sequence comparison";
    
    private static final Logger LOG = Logger.getLogger(OrthoMCLDBConverter.class);
    private IdResolver rslv;
    
    private Properties props = new Properties();
    private Map<String, String> config = new HashMap<String, String>();
    private Map<String, String> configOrganismKey = new HashMap<String, String>();
    private static String evidenceRefId = null;
    
    private Map<String, Item> finalGeneMap = new LinkedHashMap<String, Item>();
    
    /**
     * Constructor
     * @param writer the ItemWriter used to handle the resultant items
     * @param model the Model
     */
    public OrthoMCLDBConverter(ItemWriter writer, Model model) {
        super(writer, model, DATA_SOURCE_NAME, DATASET_TITLE);
        readConfigMain();
        readConfigOrganismKey();
    }

    /**
    *	Reads orthomcldb_config.properties and creates a map of key to value map
     */
    private void readConfigMain() {
        try {
            props.load(getClass().getClassLoader().getResourceAsStream(PROP_FILE_MAIN));
        } catch (IOException e) {
            throw new RuntimeException("Problem loading properties '" + PROP_FILE_MAIN + "'", e);
        }

        for (Map.Entry<Object, Object> entry : props.entrySet()) {
            String key = (String) entry.getKey(); // e.g. 10090.geneid
            String value = ((String) entry.getValue()).trim(); // e.g. symbol

            String[] attributes = key.split("\\.");
            if (attributes.length == 0) {
                throw new RuntimeException("Problem loading properties '" + PROP_FILE_MAIN + "' on line " + key);
            }
            String taxonId = attributes[0];
            config.put(taxonId, value);
        }
    }

    /**
    *	Reads orthomcldb-organism-key_config.properties and creates a map of key to value map
    *	Key = abbreviation used in orthomcldb to describe organism
    *	Value = taxon id
    */
   private void readConfigOrganismKey() {
       try {
           props.load(getClass().getClassLoader().getResourceAsStream(PROP_FILE_ORGANISM_KEY));
       } catch (IOException e) {
           throw new RuntimeException("Problem loading properties '" + PROP_FILE_ORGANISM_KEY + "'", e);
       }

       for (Map.Entry<Object, Object> entry : props.entrySet()) {
           String key = (String) entry.getKey(); // e.g. tgon
           String value = ((String) entry.getValue()).trim(); // e.g. 5811
           if (key.length() == 0 || value.length() == 0) {
        	   throw new RuntimeException("Problem loading properties '" + PROP_FILE_ORGANISM_KEY + "' on line " + key); 
           }
           configOrganismKey.put(key, value);
       }
   }
    
    /**
     * Read lines from a BufferedReader and store items to database.
     * @param reader the Reader to reader from
     * @throws IOException if there is an error during reading or parsing
     */
    public void process(Reader reader) throws IOException, ObjectStoreException {
        /*
        groups_OrthoMCL-* are delimited files containing the following
        columns:

        0) OG_ID - OrthoMCLDB group id
        1) Mixed IDs --- Gene_ID and Protein_ID mixed, e.g. tgon|TGME49_012810(toxoplasma) dmel|FBpp0070274(fly), mmus|ENSMUSP00000009631(mouse)
         */
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
        
        for( Item gene : finalGeneMap.values() ) {
        	store(gene);
        }
    }

    // IdResolver
    private void setUpResolver() {
        if (rslv == null) {
            rslv = IdResolverService.getBioMartCustomIdResolver();
        }
    }
    
    /**
     * Takes each line and process them accordingly
     */
    private void processLine(String line) throws ObjectStoreException {
    	Map<String, Item> geneMap = new LinkedHashMap<String, Item>();
    	Map<String, String> organismMap = new HashMap<String, String>();
    	
    	String[] columns = line.split(" ");

    	// Read each column
    	// group id
    	String groupID = columns[0].trim();
    	
    	// all gene and protein ids
        for (int x = 1; x < columns.length; x++) {
        	String[] ids = columns[x].split("\\|");
        	
        	String taxonID = configOrganismKey.get(ids[0]);
        	
        	if (taxonID != null) {
        		if (isValid(taxonID, ids[1].trim())) {
        			String resolvedIdentifier = resolveGene(taxonID, ids[1].trim());
        			        			
        			if (!finalGeneMap.containsKey(resolvedIdentifier)) {
        				Item geneItem = createItem("Gene");
            	        geneItem.setAttribute("primaryIdentifier", resolvedIdentifier);
            	        
            	        // special case for toxo
            	        if (taxonID == "5811") {
            	        	if (resolvedIdentifier.startsWith("TGME49")) {
            	        		geneItem.setReference("organism", getOrganism("508771"));
            	        	}
            	        	if (resolvedIdentifier.startsWith("TGGT1")) {
            	        		geneItem.setReference("organism", getOrganism("507601"));
            	        	}
            	        	if (resolvedIdentifier.startsWith("TGVEG")) {
            	        		geneItem.setReference("organism", getOrganism("432359"));
            	        	}
            	        } else {
            	        	geneItem.setReference("organism", getOrganism(taxonID));
            	        }
            	        finalGeneMap.put(resolvedIdentifier, geneItem);
            	        geneMap.put(resolvedIdentifier, geneItem);
            	        organismMap.put(resolvedIdentifier, taxonID);
        			} else {
        				geneMap.put(resolvedIdentifier, finalGeneMap.get(resolvedIdentifier));
            	        organismMap.put(resolvedIdentifier, taxonID);
        			}
        		}
        	}
        }
        
        // go through local geneMap
        for( Item gene1 : geneMap.values() ) {
        	for( Item gene2 : geneMap.values() ) {
        		if (gene1.getAttribute("primaryIdentifier").getValue() != gene2.getAttribute("primaryIdentifier").getValue()) {
        			Item homologue = createItem("Homologue");
        	        homologue.setReference("gene", finalGeneMap.get(gene1.getAttribute("primaryIdentifier").getValue()).getIdentifier());
        	        homologue.setReference("homologue", finalGeneMap.get(gene2.getAttribute("primaryIdentifier").getValue()).getIdentifier());
        	        homologue.addToCollection("evidence", getEvidence());
        	        homologue.setAttribute("type", (organismMap.get(gene1.getAttribute("primaryIdentifier").getValue()) == 
        	        		organismMap.get(gene2.getAttribute("primaryIdentifier").getValue()))? PARALOGUE : ORTHOLOGUE);
        	        store(homologue);
        	        
        	        gene1.addToCollection("homologues", gene2);
        		}
        	}
        	geneMap.put(gene1.getAttribute("primaryIdentifier").getValue(), gene1);
        }
        
        // if local geneMap does not exists in global geneMap then insert
        // otherwise, add collection of homologues
        for( Item gene : geneMap.values() ) {
        	if (!finalGeneMap.containsKey(gene.getAttribute("primaryIdentifier").getValue())) {
        		finalGeneMap.put(gene.getAttribute("primaryIdentifier").getValue(), gene);
        	} else {
        		// update if homologue collection is not 
        		Item tmpGene = finalGeneMap.get(gene.getAttribute("primaryIdentifier").getValue());
        		if (gene.hasCollection("homologues")) {
        			tmpGene.addCollection(gene.getCollection("homologues"));
            		finalGeneMap.put(gene.getAttribute("primaryIdentifier").getValue(), tmpGene);
        		} 		
        	}
        }
    }
    
    // homologues are only processed if they are of an organism of interest
    private boolean isValid(String taxonId, String identifier) {
        if (rslv == null) {
            // no id resolver available, so return the original identifier
        	LOG.info("RESOLVER: no id resolver available");
            return false;
        }
        if (!rslv.hasTaxon(taxonId)) {
            // no id resolver available, so return the original identifier
            return false;
        }
        int resCount = rslv.countResolutions(taxonId, "gene", identifier);
        if (resCount != 1) {
            return false;
        }
        return true;
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
    
    private String getEvidence() throws ObjectStoreException {
        if (evidenceRefId == null) {
            Item item = createItem("OrthologueEvidenceCode");
            item.setAttribute("abbreviation", EVIDENCE_CODE_ABBR);
            item.setAttribute("name", EVIDENCE_CODE_NAME);
            try {
                store(item);
            } catch (ObjectStoreException e) {
                throw new ObjectStoreException(e);
            }
            String refId = item.getIdentifier();

            item = createItem("OrthologueEvidence");
            item.setReference("evidenceCode", refId);
            try {
                store(item);
            } catch (ObjectStoreException e) {
                throw new ObjectStoreException(e);
            }

            evidenceRefId = item.getIdentifier();
        }
        return evidenceRefId;
    }
}
