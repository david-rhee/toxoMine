package org.toxomine.web;

/*
 * Copyright (C) 2013-2014 toxoMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.tiles.ComponentContext;
import org.apache.struts.tiles.actions.TilesAction;
import org.intermine.api.InterMineAPI;
import org.intermine.model.bio.ResultFile;
import org.intermine.objectstore.ObjectStore;
import org.intermine.web.logic.session.SessionMethods;

/**
 * Set up toxoCore experiments for display.
 * @author David Rhee
 *
 */

public class ExperimentController extends TilesAction
{
    /**
     * {@inheritDoc}
     */
    public ActionForward execute(ComponentContext context,
                                 ActionMapping mapping,
                                 ActionForm form,
                                 HttpServletRequest request,
                                 HttpServletResponse response)
        throws Exception {
        final ServletContext servletContext = servlet.getServletContext();
        final InterMineAPI im = SessionMethods.getInterMineAPI(request.getSession());
        ObjectStore os = im.getObjectStore();

        List<DisplayExperiment> experiments;
        String experimentName = request.getParameter("experiment");
        if (experimentName != null) {
            experiments = new ArrayList<DisplayExperiment>();
            experiments.add(MetadataCache.getExperimentByName(os, experimentName));
        } else {
            experiments = MetadataCache.getExperiments(os);
        }
        request.setAttribute("experiments", experiments);

        return null;
    }
}
