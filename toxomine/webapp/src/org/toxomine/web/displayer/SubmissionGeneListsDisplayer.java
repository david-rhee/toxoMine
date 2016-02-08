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

import org.intermine.model.bio.GeneList;
import org.intermine.model.bio.Submission;

/**
 * Controller for SubmissionGeneListsDisplayer.jsp
 *
 * @author David Rhee
 *
 */
public class SubmissionGeneListsDisplayer extends ReportDisplayer
{
    protected static final Logger LOG = Logger.getLogger(SubmissionGeneListsDisplayer.class);

    /**
     * constructor
     * @param config ReportDisplayerConfig
     * @param im InterMineAPI
     */
    public SubmissionGeneListsDisplayer(ReportDisplayerConfig config, InterMineAPI im) {
        super(config, im);
    }

    @Override
    public void display(HttpServletRequest request, ReportObject reportObject) {
        try {
        	// Removed logics from SubmissionGeneListsController
        	HttpSession session = request.getSession();
            final InterMineAPI im = SessionMethods.getInterMineAPI(session);
            ObjectStore os = im.getObjectStore();
            
            /**
             * Submission to GeneList
             */
            // submission object
            Submission o = (Submission) reportObject.getObject();
            LOG.info("SUBMISSION id: " + o.getId());

            //Declare Set
            Set<GeneList> geneListSet = new HashSet<GeneList>();

            //Grab all the GeneLists related to this submission
            geneListSet = o.getGeneLists();

            //Push sets to request
            request.setAttribute("TCid", o.gettCid());
            request.setAttribute("geneListCount", geneListSet.size());

        } catch (Exception err) {
            err.printStackTrace();
        }
        return;
    }
}