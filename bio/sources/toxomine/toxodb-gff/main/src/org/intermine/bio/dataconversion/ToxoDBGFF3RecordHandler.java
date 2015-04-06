package org.intermine.bio.dataconversion;

/*
 * Copyright (C) 2013 - 2014 toxoMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */

import java.util.List;
import java.util.Iterator;

import org.apache.log4j.Logger;

import org.intermine.bio.io.gff3.GFF3Record;
import org.intermine.metadata.Model;
import org.intermine.xml.full.Item;

/**
 * A converter/retriever for the Toxodb-gff dataset.
 * author David Rhee
 */

public class ToxoDBGFF3RecordHandler extends GFF3RecordHandler
{

    /**
     * Create a new ToxoGFF3RecordHandler for the given data model.
     * @param model the model for which items will be created
     */
    public ToxoDBGFF3RecordHandler (Model tgtModel) {
        super(tgtModel);
        refsAndCollections.put("Exon", "transcripts");
        refsAndCollections.put("Exon", "gene");
        refsAndCollections.put("CDS", "gene");
        refsAndCollections.put("CDS", "transcripts");
        refsAndCollections.put("CDS", "protein");
        refsAndCollections.put("TRNA", "gene");
        refsAndCollections.put("RRNA", "gene");
       	refsAndCollections.put("MRNA", "gene");
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void process(GFF3Record record) {
        Item feature = getFeature();
        String clsName = feature.getClassName();

        //if gene, add some features
        if ("Gene".equals(clsName)) {
            // set description
            if (record.getAttributes().get("description") != null) {
                String description = record.getAttributes().get("description").iterator().next();
                feature.setAttribute("description", description);   
            }
            // set alias
            if (record.getAttributes().get("Alias") != null) {
                List<String> aliases = record.getAttributes().get("Alias");
                if (aliases != null) {
                    Iterator<String> aliasIter = aliases.iterator();

                    while (aliasIter.hasNext()) {
                        String alias = aliasIter.next();
                        // create item and set the identifier for the alias
                        Item synonym = converter.createItem("Synonym");
                        synonym.setAttribute("value", alias);
                        // set the reference to the gene
                        synonym.setReference("subject", feature); 
                        // add newly created synonym to database
                        addItem(synonym);
                        // set the reverse reference 
                        feature.addToCollection("synonyms", synonym);
                    }
                }
            }
        }
		//delete symbol/name
        if ("TRNA".equals(clsName)) {
            if (feature.getAttribute("symbol") != null) {
                feature.removeAttribute("symbol");
            }
        }
        if ("RRNA".equals(clsName)) {
            if (feature.getAttribute("symbol") != null) {
                feature.removeAttribute("symbol");
            }
        }
        if ("MRNA".equals(clsName)) {
	    if (feature.getAttribute("symbol") != null) {
                feature.removeAttribute("symbol");
            }
        }
        if ("CDS".equals(clsName)) {
            if (feature.getAttribute("symbol") != null) {
                feature.removeAttribute("symbol");
            }
        }
        if ("Exon".equals(clsName)) {
            if (feature.getAttribute("symbol") != null) {
                feature.removeAttribute("symbol");
            }
        }
    }
}
