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

import org.intermine.model.bio.Submission;
import org.intermine.model.bio.AppliedProtocol;
import org.intermine.model.bio.Protocol;
import org.intermine.model.bio.SubmissionData;

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
            LOG.info("SUBMISSION id: " + o.getId());

            //Declare Set
            Set<AppliedProtocol> appliedProtocolSet = new HashSet<AppliedProtocol>();
            Set<SubmissionData> inputSubmissionDataSet = new HashSet<SubmissionData>();
            Set<SubmissionData> outputSubmissionDataSet = new HashSet<SubmissionData>();
            Set<Protocol> protocolSet = new HashSet<Protocol>();
            
            //Grab all the SubmissionData related to this submission
            protocolSet = o.getProtocols();

            //Grab all the AppliedProtocol related to this submission
            appliedProtocolSet = o.getAppliedProtocols();

            //Grab all the SubmissionData related to this applied protocol
            addToInputSubmissionDataSet(appliedProtocolSet, inputSubmissionDataSet);
            addToOutputSubmissionDataSet(appliedProtocolSet, outputSubmissionDataSet);
            
            //Push sets to request
            request.setAttribute("TCid", o.gettCid());
            request.setAttribute("protocols", protocolSet);
            request.setAttribute("appliedProtocols", appliedProtocolSet);
            request.setAttribute("inputSubmissionData", inputSubmissionDataSet);
            request.setAttribute("outputSubmissionData", outputSubmissionDataSet);
        } catch (Exception err) {
            err.printStackTrace();
        }
        return;
    }
    /**
     * Go throughs appliedProtocolSet and adds to inputSubmissionDataSet
     *
     * @param appliedProtocolSet
     * @param inputSubmissionDataSet
     */
    private static void addToInputSubmissionDataSet(Set appliedProtocolSet, Set inputSubmissionDataSet) {
    	// create an iterator
        Iterator appliedProtocolSetIterator = appliedProtocolSet.iterator();
        
        // add submission data
        while (appliedProtocolSetIterator.hasNext()){
        	AppliedProtocol ap = (AppliedProtocol) appliedProtocolSetIterator.next();
        	
        	// grab all submission data
        	Set<SubmissionData> inputsSet = new HashSet<SubmissionData>();
        	inputsSet = ap.getInputs();
        	
        	// create an iterator
            Iterator inputsSetIterator = inputsSet.iterator();

            // add submission data
            while (inputsSetIterator.hasNext()){
            	inputSubmissionDataSet.add(inputsSetIterator.next()); 
            }
        }
    }
    /**
     * Go throughs appliedProtocolSet and adds to outputSubmissionDataSet
     *
     * @param appliedProtocolSet
     * @param outputSubmissionDataSet
     */
    private static void addToOutputSubmissionDataSet(Set appliedProtocolSet, Set outputSubmissionDataSet) {
    	// create an iterator
        Iterator appliedProtocolSetIterator = appliedProtocolSet.iterator();
        
        // add submission data
        while (appliedProtocolSetIterator.hasNext()){
        	AppliedProtocol ap = (AppliedProtocol) appliedProtocolSetIterator.next();
        	
        	// grab all submission data
        	Set<SubmissionData> outputsSet = new HashSet<SubmissionData>();
        	outputsSet = ap.getOutputs();
        	
        	// create an iterator
            Iterator outputsSetIterator = outputsSet.iterator();

            // add submission data
            while (outputsSetIterator.hasNext()){
            	outputSubmissionDataSet.add(outputsSetIterator.next()); 
            }
        }
    }
}