package org.intermine.bio.dataconversion;

/*
 * Copyright (C) 2002-2015 toxoMine
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
 * A converter/retriever for the TSS GFF dataset.
 * author David Rhee
 */

public class TSSGFF3RecordHandler extends GFF3RecordHandler
{

    /**
     * Create a new TSSGFF3RecordHandler for the given data model.
     * @param model the model for which items will be created
     */
    public TSSGFF3RecordHandler (Model model) {
        super(model);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void process(GFF3Record record) {
        Item feature = getFeature();

		// set Peak in attribute		
        if (record.getAttributes().get("Peak") != null) {
            String peak = record.getAttributes().get("Peak").iterator().next();
            feature.setAttribute("peak", peak);
        }
		// set PeakCount in attribute		
        if (record.getAttributes().get("PeakCount") != null) {
            String peakCount = record.getAttributes().get("PeakCount").iterator().next();
            feature.setAttribute("peakCount", peakCount);
        }
    }
}