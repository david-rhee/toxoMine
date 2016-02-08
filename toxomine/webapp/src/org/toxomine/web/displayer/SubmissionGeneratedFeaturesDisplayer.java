package org.toxomine.web.displayer;

/*
 * Copyright (C) 2013-2015 toxoMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */

import java.util.Iterator;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.intermine.api.InterMineAPI;
import org.intermine.objectstore.ObjectStore;
import org.intermine.objectstore.ObjectStoreException;
import org.intermine.web.displayer.ReportDisplayer;
import org.intermine.web.logic.config.ReportDisplayerConfig;
import org.intermine.web.logic.results.ReportObject;
import org.intermine.web.logic.session.SessionMethods;
import org.intermine.model.bio.SequenceFeature;
import org.intermine.model.bio.Submission;

/**
 * Controller for SubmissionGeneratedFeaturesDisplayer.jsp
 *
 * @author David Rhee
 *
 */
public class SubmissionGeneratedFeaturesDisplayer extends ReportDisplayer
{
    protected static final Logger LOG = Logger.getLogger(SubmissionGeneratedFeaturesDisplayer.class);

    /**
     * constructor
     * @param config ReportDisplayerConfig
     * @param im InterMineAPI
     */
    public SubmissionGeneratedFeaturesDisplayer(ReportDisplayerConfig config, InterMineAPI im) {
        super(config, im);
    }

    @Override
    public void display(HttpServletRequest request, ReportObject reportObject) {
        try {
        	// Removed logics from SubmissionGeneratedFeaturesController
        	HttpSession session = request.getSession();
            final InterMineAPI im = SessionMethods.getInterMineAPI(session);
            ObjectStore os = im.getObjectStore();
            
            /**
             * Submission to Sequence Features
             */
            // submission object
            Submission o = (Submission) reportObject.getObject();
            LOG.info("SUBMISSION id: " + o.getId());

            //Declare Set
            Set<SequenceFeature> sequenceFeatureSet = new HashSet<SequenceFeature>();

            //Grab all the SequenceFeatures related to this submission
            sequenceFeatureSet = o.getFeatures();

            //Push sets to request
            request.setAttribute("TCid", o.gettCid());
            request.setAttribute("sequenceFeatureCount", sequenceFeatureSet.size());

        } catch (Exception err) {
            err.printStackTrace();
        }
        return;
    }
}