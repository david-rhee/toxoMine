package org.toxomine.web.displayer;

/*
 * Copyright (C) 2013-2014 ToxoMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.intermine.api.InterMineAPI;
import org.intermine.api.profile.Profile;
import org.intermine.api.query.WebResultsExecutor;
import org.intermine.api.results.WebResults;
import org.intermine.model.bio.Protocol;
//import org.intermine.model.bio.ResultFile;
import org.intermine.model.bio.Submission;
import org.intermine.objectstore.ObjectStore;
import org.intermine.objectstore.ObjectStoreException;
import org.intermine.pathquery.Constraints;
import org.intermine.pathquery.OrderDirection;
import org.intermine.pathquery.OuterJoinStatus;
import org.intermine.pathquery.PathQuery;
import org.intermine.web.displayer.ReportDisplayer;
import org.intermine.web.logic.config.ReportDisplayerConfig;
import org.intermine.web.logic.results.PagedTable;
import org.intermine.web.logic.results.ReportObject;
import org.intermine.web.logic.session.SessionMethods;

/**
 * Controller for submissionProtocolsDisplayer.jsp
 *
 * @author David Rhee
 *
 */
public class SubmissionProtocolsDisplayer extends ReportDisplayer
{
    protected static final Logger LOG = Logger.getLogger(SubmissionProtocolsDisplayer.class);

    /**
     * constructor
     * @param config ReportDisplayerConfig
     * @param im InterMineAPI
     */
    public SubmissionProtocolsDisplayer(ReportDisplayerConfig config, InterMineAPI im) {
        super(config, im);
    }

    @Override
    public void display(HttpServletRequest request, ReportObject reportObject) {
        try {
        	// Removed logics from SubmissionProtocolsController
        	HttpSession session = request.getSession();
            final InterMineAPI im = SessionMethods.getInterMineAPI(session);
            ObjectStore os = im.getObjectStore();
            
            /**
             * Submission to appliedProtocols to submissionData
             */
            // submission object
            Submission o = (Submission) reportObject.getObject();
            //LOG.info("SUBMISSION id: " + o.getId());

            // create the query
            PathQuery q = new PathQuery(os.getModel());
            q.addView("Submission.appliedProtocols.step");
            q.addView("Submission.appliedProtocols.inputs.type");
            q.addView("Submission.appliedProtocols.inputs.name");
            q.addView("Submission.appliedProtocols.inputs.value");
            q.addView("Submission.appliedProtocols.protocol.name");
            q.addView("Submission.appliedProtocols.outputs.type");
            q.addView("Submission.appliedProtocols.outputs.name");
            q.addView("Submission.appliedProtocols.outputs.value");

            q.addConstraint(Constraints.eq("Submission.id", o.getId().toString()));

            q.setOuterJoinStatus("Submission.appliedProtocols.inputs", OuterJoinStatus.OUTER);
            q.setOuterJoinStatus("Submission.appliedProtocols.outputs", OuterJoinStatus.OUTER);
            q.addOrderBy("Submission.appliedProtocols.step", OrderDirection.ASC);
            
            boolean noResults = true;
            if (q.isValid()) {
            	Profile profile = SessionMethods.getProfile(session);
                WebResultsExecutor executor = im.getWebResultsExecutor(profile);
                WebResults results;
                
                Set<Protocol> pt = new HashSet<Protocol>();
                //Set<ResultFile> rf = new HashSet<ResultFile>();

                pt = o.getProtocols();
                //rf = o.getResultFiles();

                request.setAttribute("tcid", o.getTcid());
                request.setAttribute("protocols", pt);
                //request.setAttribute("files", rf);

                results = executor.execute(q);

                if (results.size() > 2000) {
                    request.setAttribute("subId", o.getId());
                    return;
                }

                PagedTable pagedTable = new PagedTable(results);
                // NB: you need to set a maximum, default is 10!
                pagedTable.setPageSize(2000);
                request.setAttribute("pagedResults", pagedTable);
            } 

        } catch (Exception err) {
            err.printStackTrace();
        }
        return;
    }
}