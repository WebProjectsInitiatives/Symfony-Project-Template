:: ################################################################################################################
:: # symfony-project-template - Windows - Script batch - Analyse by PHP Mess Detector                      #

:: # @author: William Pinaud & Aurélien Tricard                                                     #
:: ################################################################################################################

:: Shut down Windows current command echoing
@ECHO OFF

:: Change the title of the window, for pimpin' reasons :)
:: JK: this helps finding it among all open windows
TITLE Analyze by Mess Detector

:: If command line argument is "-y", then just go on, don't ask.
IF /I "%~1"=="-y" (GOTO :start)

:: If command line argument is --help, then just go on, don't ask.
IF /I "%~1"=="--help" (GOTO :explain) ELSE (GOTO :ask)
:explain
ECHO .
ECHO Usage: Run an analysis with Mess Detector
ECHO .
ECHO -y                 force without confirmation
ECHO --help             display this help screen

:: Ask people if they really want to proceed
:ask
ECHO .
SET /P confirm="Are you SURE you want to run an analysis with Mess Detector? (Y/y/N/n) "
ECHO .

:: Use that variable prompted from user to go further or not
IF /I "%confirm%"=="y" (GOTO :start) ELSE (GOTO :bypass)

:: Start the analyse of the project by php mess detector
:start

ECHO ---------------------------------------------------
ECHO PHP Mess Detector Analyse
ECHO ---------------------------------------------------

::Check if phpstan is install
if exist devops-sources/vendor/bin/phpmd (
    ECHO Keep calm and drink a coffee! This analyse could be long!
    "devops-sources/vendor/bin/phpmd" ./ xml devops-sources/rulesets.xml --reportfile devops-sources/phpmd-report.xml --suffixes php --exclude devops-sources,php-sources
    ECHO You can see the result of the analyse in the file phpmd-report in the folder devops-sources.
) else (
    echo ""
    echo "Aborting analysis. Please config your IDE as explain in the README and launch the script of the initialization of the project."
    echo ""
    exit 1
)

:: Just stop here and go to the end!
GOTO end

:: If the user answered "n"
:bypass
ECHO OK, then. See you around! :)
ECHO ---------------------------------------------------

:: The end!
:end