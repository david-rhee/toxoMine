#!/bin/bash
#
# default usage: ../bio/scripts/toxomine/automine.sh
#
# This script will assist biologists to build toxoMine.

DATE=`date +%d-%m-%Y`
LOG=toxomine-build.$DATE.log

echo ""
echo "Autobuild script will help you to build humanMine in an interactive way."
echo "Usage:" 
echo "IM_REPO/humanmine$ ../bio/scripts/humanmine/autobuild.sh"
echo ""
echo "Prerequisites:"
echo "* Run project build on theleviathan with correct configurations for Postgres and MySQL databases"
echo "* Email client (sudo apt-get install mailutils) is installed and properly configured"
echo "* Check parsers are up-to-date with model changes and data format changes"
echo "* humanmine.properties.build.theleviathan and humanmine.properties.webapp.theleviathanin are in ~/.intermine directory"
echo "* Keep your git repository up-to-date"
echo "* Download and load Ensembl databases to MySQL"
echo "* Datasets need to download manually"
echo ""
echo "Note:"
echo "* Run this script from humanmine directory"
echo "* Database dumps are in SAN dumps directory"
echo "* Logs are in SAN log directory"
echo ""

#----------------------------- Functions -----------------------------

update_datasets() {
    # Ref http://intermine.readthedocs.org/en/latest/database/download-scripts/?highlight=data%20download
    if [ -z "$1" ]
        then
            echo "Update all the datasets in toxomine.yml (Ref https://github.com/intermine/intermine/blob/dev/bio/scripts/DataDownloader/config/intermine.yml)"
            echo ""
            perl ../bio/scripts/DataDownloader/bin/download_data -e intermine
    else
        echo "Update datasets: $@"
        echo ""
        perl ../bio/scripts/DataDownloader/bin/download_data -e intermine $@        
    fi
}

#---------------------------------------------------------------

# Ref http://stackoverflow.com/questions/226703/how-do-i-prompt-for-input-in-a-linux-shell-script
while true; do
    echo "Would you like to:" 
    echo "[1] Update all datasets by download script"
    echo "[2] Update any datasets"
    echo "[3] Run a fresh project build" 
    echo "[4] Restart from a broken build"
    echo "[5] Run datasources"
    echo "[6] Run a single postprocess"
    echo "[7] Run template comparison"
    echo "[8] Run acceptance tests"
    echo "[9] Run [7]&[8]"
    echo "[10] Release webapp"
    echo "[11] All-in-one"
    echo "[12] Exit"
    read -p "Please select one of the options: " num
    case $num in
        1  ) update_datasets; break;;
        2  ) echo "Please enter the dataset names separated by space:"; read DATASET_NAMES; update_datasets $DATASET_NAMES; break;;
        3  ) run_project_build; break;;
        4  ) restart_project_build; break;;
        5  ) echo "Please enter the sources separated by comma, e.g. omim,hpo:"; read SOURCE_NAMES; run_sources $SOURCE_NAMES; break;;
        6  ) echo "Please enter the postprocess:"; read POSTPROCESS; run_a_postprocess $POSTPROCESS; break;;
        7  ) echo "Please enter the service url (e.g. www.flymine.org/query [beta.flymine.org/beta] [email@to] [email@from]) or press enter to use default setting:"; read TC_PARA; run_template_comparison $TC_PARA; break;;
        8  ) run_acceptance_tests; break;;
        9  ) run_template_comparison_and_acceptance_tests; break;;
        10  ) release_webapp; break;;
        11 ) run_all_in_one; break;;
        12 ) echo "Bye"; exit;;
        * ) echo "Please select.";;
    esac
done