:: ################################################################################################################
:: # symfony-project-template - Windows - Script batch - Analyse by PHP Insights                           #

:: # @author: William Pinaud & Aurélien Tricard                                                     #
:: ################################################################################################################

:: Shut down Windows current command echoing
@echo off

:: Change the title of the window, for pimpin' reasons :)
:: JK: this helps finding it among all open windows
TITLE Analyze by PHP-Insights

:: if command line argument is "-y", then just go on, don't ask.
if /I "%~1"=="-y" (goto :start)

:: if command line argument is --help, then just go on, don't ask.
if /I "%~1"=="--help" (goto :explain) ELSE (goto :ask)
:explain
echo .
echo Usage: Run an analysis with PHP-Insights
echo .
echo -y                 force without confirmation
echo --help             display this help screen

:: Ask people if they really want to proceed
:ask
echo .
set /P confirm="Are you SURE you want to run an analysis with PHP-Insights? (Y/y/N/n) "
echo .

:: Use that variable prompted from user to go further or not
if /I "%confirm%"=="y" (goto :start) ELSE (goto :bypass)

:: Start the initialization of the project
:start

echo ---------------------------------------------------
echo PHP Insights Analyse
echo ---------------------------------------------------

::Check if phpinsights is install
if exist devops-sources/vendor/bin/phpinsights (
    "devops-sources/vendor/bin/phpinsights"
) else (
    echo ""
    echo "Aborting analysis. Please config your IDE as explain in the README and launch the script of the initialization of the project."
    echo ""
    exit 1
)

:: Just stop here and go to the end!
goto end

:: if the user answered "n"
:bypass
echo OK, then. See you around! :)
echo ---------------------------------------------------

:: The end!
:end