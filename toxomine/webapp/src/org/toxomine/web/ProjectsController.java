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
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.HashSet;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.tiles.ComponentContext;
import org.apache.struts.tiles.actions.TilesAction;
import org.intermine.api.InterMineAPI;
import org.intermine.objectstore.ObjectStore;
import org.intermine.web.logic.session.SessionMethods;

//added by David Rhee
import org.intermine.api.profile.Profile;
import org.intermine.api.query.PathQueryExecutor;
import org.intermine.api.results.ExportResultsIterator;
import org.intermine.api.results.ResultElement;
import org.intermine.objectstore.ObjectStore;
import org.intermine.objectstore.query.ConstraintOp;
import org.intermine.objectstore.query.ContainsConstraint;
import org.intermine.objectstore.query.Query;
import org.intermine.objectstore.query.QueryClass;
import org.intermine.objectstore.query.QueryCollectionReference;
import org.intermine.objectstore.query.QueryField;
import org.intermine.objectstore.query.Results;
import org.intermine.objectstore.query.ResultsRow;
import org.intermine.pathquery.Constraints;
import org.intermine.pathquery.OrderDirection;
import org.intermine.pathquery.PathQuery;


/**
 * Set up toxoCore projects for display.
 * @author David Rhee
 *
 */

public class ProjectsController extends TilesAction
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
        try {
            final InterMineAPI im = SessionMethods.getInterMineAPI(request.getSession());
            ObjectStore os = im.getObjectStore();

            /**
             * Project to Labs
             */
            Map projectLabs = new HashMap<String, Set<String>>();
            
            PathQuery q = new PathQuery(im.getModel());
            q.addViews("Project.name", "Project.labs.name");
            q.addOrderBy("Project.name", OrderDirection.ASC);
            
            boolean noResults = true;
            if (q.isValid()) {
                Profile profile = SessionMethods.getProfile(request.getSession());
                PathQueryExecutor executor = im.getPathQueryExecutor(profile);
                ExportResultsIterator it = executor.execute(q);
                while (it.hasNext()) {
                    List<ResultElement> row = it.next();
                    String projectName =  (String) row.get(0).getField();
                    String labsName =  (String) row.get(1).getField();
                    addToSetMap(projectLabs, projectName, labsName);
                }
                request.setAttribute("projectLabs", projectLabs);
            } 

            /**
             * Project to Experiments
             */          
            Map projectExperiments = new HashMap<String, Set<String>>();
            
            PathQuery qq = new PathQuery(im.getModel());
            qq.addViews("Project.name", "Project.experiments.name");
            qq.addOrderBy("Project.name", OrderDirection.ASC);
            
            boolean noResultss = true;
            if (qq.isValid()) {
                Profile profile = SessionMethods.getProfile(request.getSession());
                PathQueryExecutor executor = im.getPathQueryExecutor(profile);
                ExportResultsIterator it = executor.execute(qq);
                while (it.hasNext()) {
                    List<ResultElement> row = it.next();
                    String projectName =  (String) row.get(0).getField();
                    String experimentsName =  (String) row.get(1).getField();
                    addToSetMap(projectExperiments, projectName, experimentsName);
                }
                request.setAttribute("projectExperiments", projectExperiments);
            } 

            
            /**
             * Experiment to Submissions
             */
            Map experimentSubmissions = new HashMap<String, Set<String>>();
            
            PathQuery qqq = new PathQuery(im.getModel());
            qqq.addViews("Experiment.name", "Experiment.submissions.name");
            qqq.addOrderBy("Experiment.name", OrderDirection.ASC);
            
            boolean noResultsss = true;
            if (qqq.isValid()) {
                Profile profile = SessionMethods.getProfile(request.getSession());
                PathQueryExecutor executor = im.getPathQueryExecutor(profile);
                ExportResultsIterator it = executor.execute(qqq);
                while (it.hasNext()) {
                    List<ResultElement> row = it.next();
                    String experimentName =  (String) row.get(0).getField();
                    String submissionsName =  (String) row.get(1).getField();

                    addToSetMap(experimentSubmissions, experimentName, submissionsName);
                }
                request.setAttribute("experimentSubmissions", experimentSubmissions);
            } 

            /**
             * Project to Features
             */
//            Map<String, Integer> projectFeatures = new HashMap<String, Integer>();
//            
//            PathQuery qqqq = new PathQuery(im.getModel());
//            qqqq.addViews("Project.name", "Project.submissions.features.primaryIdentifier");
//            qqqq.addOrderBy("Project.name", OrderDirection.ASC);
//            
//            boolean noResultssss = true;
//            if (qqqq.isValid()) {
//                Profile profile = SessionMethods.getProfile(request.getSession());
//                PathQueryExecutor executor = im.getPathQueryExecutor(profile);
//                ExportResultsIterator it = executor.execute(qqqq);
//                while (it.hasNext()) {
//                    List<ResultElement> row = it.next();
//                    String projectName =  (String) row.get(0).getField();
//                    addToCountMap(projectFeatures, projectName);
//                }  
//                request.setAttribute("projectFeatures", projectFeatures);
//            }
            
        } catch (Exception err) {
            err.printStackTrace();
        }
        return null;
    }
    
    /**
     * Add a value to a Map from keys to Set of values, creating the value list
     * as needed.
     *
     * @param map the Map
     * @param key the key
     * @param value the value
     */
    private static void addToSetMap(Map map, Object key, Object value) {
        if (map == null) {
            throw new IllegalArgumentException("invalid map");
        }
        if (key == null) {
            throw new IllegalArgumentException("invalid map key");
        }
        Set valuesList = (Set) map.get(key);
        if (valuesList == null) {
            valuesList = new HashSet();
            map.put(key, valuesList);
        }
        valuesList.add(value);
    }

    /**
     * Check if key exists for a Map, if so add to 1 to its value.
     *
     * @param map the Map
     * @param key the key
     * @param value the value
     */
    private static void addToCountMap(Map map, Object key) {
        if (map == null) {
            throw new IllegalArgumentException("invalid map");
        }
        if (key == null) {
            throw new IllegalArgumentException("invalid map key");
        }
        if (map.containsKey(key)) {
        	Integer tempValue = (Integer)map.get(key);
        	map.put(key, tempValue + 1);
        } else {
        	map.put(key, 0);
        }
    }
}
