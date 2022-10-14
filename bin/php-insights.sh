#!/bin/bash

################################################################################################################
# symfony-project-template - Windows - Script bash - Analyse by PHP Insights                            #

# @author: William Pinaud & Aurélien Tricard                                                     #
################################################################################################################

# Check if the user want information about the script
if [[ "$1" == "--help" ]]
then
    echo .
    echo Usage: Run an analysis with PHP insights
    echo .
    echo -y                 force without confirmation
    echo --help             display this help screen
    exit 1
fi

# Ask user if they really want to proceed
if [[ "$1" != "-y" ]]
then
    echo "Are you SURE you want to run an analysis with PHP insights? (Y/y/N/n)"
    read rep
    if [[ "${rep}" == "n" ]] || [[ "${rep}" == "N" ]]
    then
        echo "OK, then. See you around! :)"
        echo ---------------------------------------------------
        exit 1
    fi
fi

# Check if phpinsights is install
if [[ `find devops-sources/vendor/bin/ -name "phpinsights"` ]]
then

    echo ---------------------------------------------------
    echo PHP Insights Analyse
    echo ---------------------------------------------------

    "devops-sources/vendor/bin/phpinsights"

else
    echo ""
    echo "Aborting analysis. Please config your IDE as explain in the README and launch the script of the initialization of the project."
    echo ""
    exit 1
fi
