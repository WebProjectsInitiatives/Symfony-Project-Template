:: ################################################################################################################
:: # symfony-project-template - Windows - Script batch - Analyse by PHP Stan                               #

:: # @author: William Pinaud & Aurélien Tricard                                                     #
:: ################################################################################################################

:: Shut down Windows current command echoing
@ECHO OFF

:: Change the title of the window, for pimpin' reasons :)
:: JK: this helps finding it among all open windows
TITLE Analyze by PHP-Stan

:: If command line argument is "-y", then just go on, don't ask.
IF /I "%~1" =="-y" (GOTO :start)

:: If command line argument is --help, then just go on, don't ask.
IF /I "%~1"=="--help" (GOTO :explain) ELSE (GOTO :ask)
:explain
ECHO .
ECHO Usage: Run an analysis with PHP-Stan
ECHO .
ECHO -y                 force without confirmation
ECHO --help             display this help screen

:: Ask people if they really want to proceed
:ask
ECHO .
SET /P confirm="Are you SURE you want to run an analysis with PHP-Stan? (Y/y/N/n) "
ECHO .

:: Use that variable prompted from user to go further or not
IF /I "%confirm%"=="y" (GOTO :start) ELSE (GOTO :bypass)

:: Start the initialization of the project
:start

ECHO ---------------------------------------------------
ECHO PHP Stan Analyse
ECHO ---------------------------------------------------

::Check if phpstan is install
if exist devops-sources/vendor/bin/phpstan (
    "devops-sources/vendor/bin/phpstan" analyse -c devops-sources/phpstan.neon --memory-limit 4G ./
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