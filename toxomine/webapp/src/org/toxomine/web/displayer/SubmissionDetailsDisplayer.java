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

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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

import org.intermine.model.bio.Lab;
import org.intermine.model.bio.Project;
import org.intermine.model.bio.Experiment;
import org.intermine.model.bio.Submission;

/**
 * Controller for SubmissionDetailsDisplayer.jsp
 *
 * @author David Rhee
 *
 */
public class SubmissionDetailsDisplayer extends ReportDisplayer
{
    protected static final Logger LOG = Logger.getLogger(SubmissionDetailsDisplayer.class);

    /**
     * constructor
     * @param config ReportDisplayerConfig
     * @param im InterMineAPI
     */
    public SubmissionDetailsDisplayer(ReportDisplayerConfig config, InterMineAPI im) {
        super(config, im);
    }

    @Override
    public void display(HttpServletRequest request, ReportObject reportObject) {
        try {
        	// Removed logics from SubmissionPropertiesController
        	HttpSession session = request.getSession();
            final InterMineAPI im = SessionMethods.getInterMineAPI(session);
            ObjectStore os = im.getObjectStore();
            
            /**
             * Submission
             */
            // submission object
            Submission o = (Submission) reportObject.getObject();
            LOG.info("SUBMISSION id: " + o.getId());

            SimpleDateFormat formatter = new SimpleDateFormat("dd MMMM yyyy");
            String publicReleaseDate;
            if (o.getPublicReleaseDate() != null) {
            	publicReleaseDate = formatter.format(o.getPublicReleaseDate());
            } else {
            	publicReleaseDate = "not available";
            }

            Date today = Calendar.getInstance().getTime();
            if (o.getEmbargoDate().after(today)) { // in the future
                request.setAttribute("embargoDate", formatter.format(o.getEmbargoDate()));
            }

            //Declare Set
            Set<Lab> labSet = new HashSet<Lab>();
            Set<Project> projectSet = new HashSet<Project>();
            Set<Experiment> experimentSet = new HashSet<Experiment>();
            
            //Grab all the SubmissionProperties related to this submission
            labSet = o.getLabs();
            projectSet = o.getProjects();
            experimentSet = o.getExperiments();
            
            request.setAttribute("TCid", o.gettCid());
            request.setAttribute("description", o.getDescription());
            request.setAttribute("design", o.getDesign());
            request.setAttribute("technique", o.getTechnique());
            request.setAttribute("qualityControl", o.getQualityControl());
            request.setAttribute("replicate", o.getReplicate());
            request.setAttribute("publicReleaseDate", publicReleaseDate);
            request.setAttribute("labs", labSet);
            request.setAttribute("projects", projectSet);
            request.setAttribute("experiments", experimentSet);

        } catch (Exception err) {
            err.printStackTrace();
        }
        return;
    }
}