#!/bin/bash

################################################################################################################
# symfony-project-template - Windows - Script bash - Analyse by Code Sniffer                            #

# @author: William Pinaud & Aurélien Tricard                                                     #
################################################################################################################

# Check if the user want information about the script
if [[ "$1" == "--help" ]]
then
    echo .
    echo Usage: Run an analysis with Code Sniffer
    echo .
    echo -y                 force without confirmation
    echo --help             display this help screen
    exit 1
fi

# Ask user if they really want to proceed
if [[ "$1" != "-y" ]]
then
    echo "Are you SURE you want to run an analysis with Code Sniffer? (Y/y/N/n)"
    read rep
    if [[ "${rep}" == "n" ]] || [[ "${rep}" == "N" ]]
    then
        echo "OK, then. See you around! :)"
        echo ---------------------------------------------------
        exit 1
    fi
fi

# Check if phpcs is install
if [[ `find devops-sources/vendor/bin/ -name "phpcs"` ]]
then
    echo .
    echo ---------------------------------------------------
    echo PHP Code Sniffer - Configuration settings
    echo ---------------------------------------------------
    "devops-sources/vendor/bin/phpcs" --config-set severity 5
    "devops-sources/vendor/bin/phpcs" --config-set report_width auto
    "devops-sources/vendor/bin/phpcs" --config-set color 1
    "devops-sources/vendor/bin/phpcs" --config-set show_progress 1
    "devops-sources/vendor/bin/phpcs" --config-set show_warnings 1

    echo .
    echo ---------------------------------------------------
    echo PHP Code Sniffer - Analyse
    echo ---------------------------------------------------
    "devops-sources/vendor/bin/phpcs" -d memory_limit=4G -v --extensions=php --ignore=devops-sources/*,php-sources/*,vendor/*, var/* ./
else
    echo ""
    echo "Aborting analysis. Please config your IDE as explain in the README and launch the script of the initialization of the project."
    echo ""
    exit 1
fi
