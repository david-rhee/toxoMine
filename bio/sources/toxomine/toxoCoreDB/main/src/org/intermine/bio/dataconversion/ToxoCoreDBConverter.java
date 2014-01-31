package org.intermine.bio.dataconversion;

/*
 * Copyright (C) 2002-2011 FlyMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */

import java.util.ArrayList;
import java.util.List;

import org.intermine.dataconversion.ItemWriter;
import org.intermine.metadata.Model;
import org.intermine.sql.Database;
import org.intermine.xml.full.Item;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.intermine.objectstore.ObjectStoreException;

/**
 * 
 * @author
 */
public class ToxoCoreDBConverter extends BioDBConverter
{
    // 
    private static final String DATASET_TITLE = "toxoCore Database";
    private static final String DATA_SOURCE_NAME = "db.toxocore";


    /**
     * Construct a new ToxoCoreDBConverter.
     * @param database the database to read from
     * @param model the Model used by the object store we will write to with the ItemWriter
     * @param writer an ItemWriter used to handle Items created
     */
    public ToxoCoreDBConverter(Database database, Model model, ItemWriter writer) {
        super(database, model, writer, DATA_SOURCE_NAME, DATASET_TITLE);
    }


    /**
     * {@inheritDoc}
     */
    public void process() throws Exception {
        // a database has been initialised from properties starting with db.toxoCore
        Connection connection = getDatabase().getConnection();
        
        // start reading in tables
        readProjects(connection);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public String getDataSetTitle(int taxonId) {
        return DATASET_TITLE;
    }

    // process data with direct SQL queries on the source database, for example:    
    // Statement stmt = connection.createStatement();
    // String query = "select column from table;";
    // ResultSet res = stmt.executeQuery(query);
    // while (res.next()) {
    // }
    private void readProjects(Connection connection) throws ObjectStoreException, SQLException {
        Statement stmt = connection.createStatement();
        String query = "select project_id, project_name, project_description from project;";

        ResultSet res = stmt.executeQuery(query);
        while (res.next()) {
            Integer projectId = res.getInt("project_id");
            String projectName = res.getString("project_name");
            String projectDescription = res.getString("project_description");

            Item project = createItem("Project");
            project.setAttribute("name", projectName);
            project.setAttribute("description", projectDescription);

            List<Item> experiments = readExperiments(connection, projectId, project);
            for (int x = 0; x < experiments.size(); x++) {
                project.addToCollection("experiments", experiments.get(x));
            }
            //project.setCollection(experiments);
            store(project);
        }
        res.close();
    }

    private List<Item> readExperiments(Connection connection, Integer project_id, Item project) throws ObjectStoreException, SQLException {
        Statement stmt = connection.createStatement();
        String query = "select experiment_name, experiment_description, project_id from experiment where project_id = '"
        + project_id.toString()
        + "'";

        List<Item> experiments = new ArrayList<Item>();

        ResultSet res = stmt.executeQuery(query);
        while (res.next()) {
            String experimentName = res.getString("experiment_name");
            String experimentDescription = res.getString("experiment_description");

            Item experiment = createItem("Experiment");
            experiment.setAttribute("name", experimentName);
            experiment.setAttribute("description", experimentDescription);
            experiment.setReference("project", project);
            store(experiment);
            
            experiments.add(experiment);
        }
        res.close();
        return experiments;
    }
}