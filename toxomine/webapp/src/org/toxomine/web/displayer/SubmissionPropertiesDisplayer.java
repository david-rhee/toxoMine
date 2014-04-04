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
import org.intermine.model.bio.DataAnalysis;
import org.intermine.model.bio.DataAttribute;
import org.intermine.model.bio.ExperimentalFactor;
import org.intermine.model.bio.MicroArray;
import org.intermine.model.bio.Sequencing;
import org.intermine.model.bio.Antibody;
import org.intermine.model.bio.ToxoplasmaMutant;
/*import org.intermine.model.bio.PersistentDataFile;
import org.intermine.model.bio.SubmissionDataFile;*/

/**
 * Controller for SubmissionPropertiesDisplayer.jsp
 *
 * @author David Rhee
 *
 */
public class SubmissionPropertiesDisplayer extends ReportDisplayer
{
    protected static final Logger LOG = Logger.getLogger(SubmissionPropertiesDisplayer.class);

    /**
     * constructor
     * @param config ReportDisplayerConfig
     * @param im InterMineAPI
     */
    public SubmissionPropertiesDisplayer(ReportDisplayerConfig config, InterMineAPI im) {
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
             * Submission to submission properties
             */
            // submission object
            Submission o = (Submission) reportObject.getObject();
            LOG.info("SUBMISSION id: " + o.getId());

            //Declare Set
            Set<DataAnalysis> dataAnalysisSet = new HashSet<DataAnalysis>();
            Set<DataAttribute> dataAttributeSet = new HashSet<DataAttribute>();
            Set<ExperimentalFactor> experimentalFactorSet = new HashSet<ExperimentalFactor>();
            Set<MicroArray> microArraySet = new HashSet<MicroArray>();
            Set<Sequencing> sequencingSet = new HashSet<Sequencing>();
            Set<Antibody> antibodySet = new HashSet<Antibody>();
            Set<ToxoplasmaMutant> toxoplasmaMutantSet = new HashSet<ToxoplasmaMutant>();
/*            Set<PersistentDataFile> persistentDataFileSet = new HashSet<PersistentDataFile>();
            Set<SubmissionDataFile> submissionDataFileSet = new HashSet<SubmissionDataFile>();*/
 
            //Grab all the SubmissionProperties related to this submission
            dataAnalysisSet = o.getDataAnalyses();
            dataAttributeSet = o.getDataAttributes();
            experimentalFactorSet = o.getExperimentalFactors();
            microArraySet = o.getMicroArrays();
            sequencingSet = o.getSequencing();
            antibodySet = o.getAntibodies();
            toxoplasmaMutantSet = o.getToxoplasmaMutants();
/*            persistentDataFileSet = o.getPersistentDataFiles();
            submissionDataFileSet = o.getSubmissionDataFiles();*/
            
            //Push sets to request
            request.setAttribute("TCid", o.gettCid());
            request.setAttribute("organism", o.getOrganism());
            request.setAttribute("dataAnalyses", dataAnalysisSet);
            request.setAttribute("dataAttributes", dataAttributeSet);
            request.setAttribute("experimentalFactors", experimentalFactorSet);
            request.setAttribute("microArrays", microArraySet);
            request.setAttribute("sequencings", sequencingSet);
            request.setAttribute("antibodies", antibodySet);
            request.setAttribute("toxoplasmaMutants", toxoplasmaMutantSet);
/*            request.setAttribute("persistentDataFiles", persistentDataFileSet);
            request.setAttribute("submissionDataFiles", submissionDataFileSet);*/
        } catch (Exception err) {
            err.printStackTrace();
        }
        return;
    }
}