package org.toxomine.web;

/*
 * Copyright (C) 2013-2015 toxoMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */

import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.intermine.api.InterMineAPI;
import org.intermine.api.profile.Profile;
import org.intermine.api.query.WebResultsExecutor;
import org.intermine.api.results.WebResults;
import org.intermine.api.util.NameUtil;
import org.intermine.bio.web.model.GenomicRegion;
import org.intermine.bio.web.struts.GFF3ExportForm;
import org.intermine.bio.web.struts.SequenceExportForm;
import org.intermine.metadata.Model;
import org.intermine.objectstore.ObjectStore;
import org.intermine.pathquery.Constraints;
import org.intermine.pathquery.OrderDirection;
import org.intermine.pathquery.OuterJoinStatus;
import org.intermine.pathquery.PathQuery;
import org.intermine.util.StringUtil;
import org.intermine.web.logic.bag.BagHelper;
import org.intermine.web.logic.config.WebConfig;
import org.intermine.web.logic.export.http.TableExporterFactory;
import org.intermine.web.logic.export.http.TableHttpExporter;
import org.intermine.web.logic.results.PagedTable;
import org.intermine.web.logic.session.SessionMethods;
import org.intermine.web.struts.ForwardParameters;
import org.intermine.web.struts.InterMineAction;
import org.intermine.web.struts.TableExportForm;

import org.intermine.model.bio.Submission;

/**
 * Generate queries for gene list.
 *
 * @author Richard Smith
 * @author David Rhee
 */
public class GeneListsAction extends InterMineAction
{
    @SuppressWarnings("unused")
    private static final Logger LOG = Logger.getLogger(GeneListsAction.class);

    /**
     * Action for creating a bag of InterMineObjects or Strings from identifiers in text field.
     *
     * @param mapping The ActionMapping used to select this instance
     * @param form The optional ActionForm bean for this request (if any)
     * @param request The HTTP request we are processing
     * @param response The HTTP response we are creating
     * @return an ActionForward object defining where control goes next
     * @exception Exception if the application business logic throws
     *  an exception
     */
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {

        HttpSession session = request.getSession();
        final InterMineAPI im = SessionMethods.getInterMineAPI(session);
        ObjectStore os = im.getObjectStore();
        Model model = im.getModel();

        String type = request.getParameter("type");
        String action = request.getParameter("action");

        String tcId = null;

        boolean doGzip = false;
        if (request.getParameter("gzip") != null && "true".equalsIgnoreCase(request.getParameter("gzip"))) {
            doGzip = true;
        }

        PathQuery q = new PathQuery(model);

        if ("submission".equals(type)) {
            tcId = request.getParameter("submission");

            q.addView("GeneList.name");
            q.addView("GeneList.readCount");
            q.addView("GeneList.gene.primaryIdentifier");
            q.addConstraint(Constraints.eq("GeneList.submission.TCid", tcId));
        }

        if ("results".equals(action)) {
            String qid = SessionMethods.startQueryWithTimeout(request, false, q);
            Thread.sleep(200);

            return new ForwardParameters(mapping.findForward("waiting")).addParameter("qid", qid).forward();
        } else if ("export".equals(action)) {
            String format = request.getParameter("format");

            Profile profile = SessionMethods.getProfile(session);
            WebResultsExecutor executor = im.getWebResultsExecutor(profile);
            PagedTable pt = new PagedTable(executor.execute(q));

            if (pt.getWebTable() instanceof WebResults) {
                ((WebResults) pt.getWebTable()).goFaster();
            }

            WebConfig webConfig = SessionMethods.getWebConfig(request);
            TableExporterFactory factory = new TableExporterFactory(webConfig);

            TableHttpExporter exporter = factory.getExporter(format);

            if (exporter == null) {
                throw new RuntimeException("unknown export format: " + format);
            }

            TableExportForm exportForm = new TableExportForm();
            exportForm.setIncludeHeaders(true);

            exporter.export(pt, request, response, exportForm, null, null);

            return null;
            
        } else if ("list".equals(action)) {
            q.addView("GeneList.id");
            tcId = request.getParameter("submission");

            Profile profile = SessionMethods.getProfile(session);

            String bagName = ("submission_" + tcId) + "_GeneList_genes";
            bagName = NameUtil.generateNewName(profile.getSavedBags().keySet(), bagName);
            BagHelper.createBagFromPathQuery(q, bagName, q.getDescription(), "GeneList", profile, im);
            ForwardParameters forwardParameters = new ForwardParameters(mapping.findForward("bagDetails"));
            return forwardParameters.addParameter("bagName", bagName).forward();
        }
        return null;
    }
}

