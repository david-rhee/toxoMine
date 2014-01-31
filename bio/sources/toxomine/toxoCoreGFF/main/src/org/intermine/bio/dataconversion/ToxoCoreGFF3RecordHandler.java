package org.intermine.bio.dataconversion;

/*
 * Copyright (C) 2002-2011 toxoMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * 
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import org.intermine.bio.io.gff3.GFF3Record;
import org.intermine.metadata.Model;
import org.intermine.xml.full.Item;

/**
 * A converter/retriever for the ToxoCore GFF dataset.
 */

public class ToxoCoreGFF3RecordHandler extends GFF3RecordHandler
{
    /**
     *	Map to store submission objects which will allow to store only unique objects
     */
    private Map<String, Item> tcIdMap = new LinkedHashMap<String, Item>();

    /**
     * Create a new ToxoCoreGFF3RecordHandler for the given data model.
     * @param model the model for which items will be created
     */
    public ToxoCoreGFF3RecordHandler (Model model) {
        super(model);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void process(GFF3Record record) {
        Item feature = getFeature();

	// set Submission in attribute
	if (record.getAttributes().get("Submission") != null) {
	    //String submissionFeature = record.getAttributes().get("Submission").iterator().next();
	    //
	    //Item submission = converter.createItem("Submission");
	    //submission.setAttribute("name", submissionFeature);
	    //submission.addToCollection("features", feature);
	    //addItem(submission);
	    //
	    //feature.addToCollection("submissions", submissionFeature);
	//    List<String> submissions = record.getAttributes().get("Submission");
	//    if (submissions != null) {
	//	Iterator<String> submissionIter = submissions.iterator();
	//
	//	while (submissionIter.hasNext()) {
	//	    String submission = submissionIter.next();
	//	    
	//	    Item submissionItem = converter.createItem("Submission");
	//	    submissionItem.setAttribute("tcid", submission);
	//	    submissionItem.addToCollection("features", feature);
	//	    addItem(submissionItem);
	//	    
	//	    feature.addToCollection("submissions", submissionItem);
	//	}
	//    }
	    List<String> submissions = record.getAttributes().get("Submission");
	    if (submissions != null) {
		Iterator<String> submissionIter = submissions.iterator();
		List<String> submissionItems = new ArrayList<String>();

		while (submissionIter.hasNext()) {
		    String submission = submissionIter.next();
		    submissionItems.add(getSubmission(submission).getIdentifier());
		}
    
		feature.setCollection("submissions", submissionItems);
	    }
	}
    }

    private Item getSubmission(String tcId) {
        if (tcIdMap.containsKey(tcId)) {
            return tcIdMap.get(tcId);
        }
	Item submissionItem = converter.createItem("Submission");
	submissionItem.setAttribute("tcid", tcId);
	//submissionItem.addToCollection("features", feature);
	addItem(submissionItem);
	tcIdMap.put(tcId, submissionItem);
	return submissionItem;
    }
}