#!/bin/bash

################################################################################################################
# symfony-project-template - Windows - Script batch - Analyse by PHP Mess Detector                      #

# @author: William Pinaud & Aurélien Tricard                                                     #
################################################################################################################

# Check if the user want information about the script
if [[ "$1" == "--help" ]]
then
    echo .
    echo Usage: Run an analysis with Mess Detector
    echo .
    echo -y                 force without confirmation
    echo --help             display this help screen
    exit 1
fi

# Ask user if they really want to proceed
if [[ "$1" != "-y" ]]
then
    echo "Are you SURE you want to run an analysis with Mess Detecteor? (Y/y/N/n)"
    read rep
    if [[ "${rep}" == "n" ]] || [[ "${rep}" == "N" ]]
    then
        echo "OK, then. See you around! :)"
        echo ---------------------------------------------------
        exit 1
    fi
fi

# Check if phpmd is install
if [[ `find devops-sources/vendor/bin/ -name "phpmd"` ]]
then
    echo "Keep calm and drink a coffee! This analyse could be long!"

    "devops-sources/vendor/bin/phpmd" ./ xml devops-sources/rulesets.xml --reportfile devops-sources/phpmd-report.xml --suffixes php --exclude devops-sources,php-sources,vendor,var

    echo "You can see the result of the analyse in the file phpmd-report in the folder devops-sources."
else
    echo ""
    echo "Aborting analysis. Please config your IDE as explain in the README and launch the script of the initialization of the project."
    echo ""
    exit 1
fi
