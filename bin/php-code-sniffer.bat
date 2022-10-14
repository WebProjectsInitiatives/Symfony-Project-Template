:: ################################################################################################################
:: # symfony-project-template - Windows - Script Batch - Analyse by Code Sniffer                           #

:: # @author: William Pinaud & Aurélien Tricard                                                     #
:: ################################################################################################################

:: Shut down Windows current command echoing
@echo off

:: Change the title of the window, for pimpin' reasons :)
:: JK: this helps finding it among all open windows
TITLE Analyze by Code Sniffer

:: If command line argument is "-y", then just go on, don't ask.
IF /I "%~1"=="-y" (goto :start)

:: If command line argument is --help, then just go on, don't ask.
IF /I "%~1"=="--help" (goto :explain) ELSE (goto :ask)
:explain
echo .
echo Usage: Run an analysis with Code Sniffer
echo .
echo -y                 force without confirmation
echo --help             display this help screen

:: Ask people if they really want to proceed
:ask
echo .
set /P confirm="Are you SURE you want to run an analysis with Code Sniffer? (Y/y/N/n) "
echo .

:: Use that variable prompted from user to go further or not
IF /I "%confirm%"=="y" (goto :start) ELSE (goto :bypass)

:: Start the initialization of the project
:start

echo ---------------------------------------------------
echo PHP Code Sniffer
echo ---------------------------------------------------

::Check if phpcs is install
if exist devops-sources/vendor/bin/phpcs (
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
    "devops-sources/vendor/bin/phpcs" -d memory_limit=4G -v --extensions=php --ignore=devops-sources/*,php-sources/* ./

) else (
    echo ""
    echo "Aborting analysis. Please config your IDE as explain in the README and launch the script of the initialization of the project."
    echo ""
    exit 1
)

:: Just stop here and go to the end!
goto end

:: If the user answered "n"
:bypass
echo OK, then. See you around! :)
echo ---------------------------------------------------

:: The end!
:end