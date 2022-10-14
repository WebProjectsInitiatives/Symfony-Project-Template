:: ################################################################################
:: # symfony-project-template - Windows - Script Batch - Initialization of the project    #

:: # @author: William Pinaud & Aurélien Tricard                     #
:: ################################################################################

:: Shut down Windows current command echoing
@echo OFF

:: Change the title of the window, for pimpin' reasons :)
:: JK: this helps finding it among all open windows
TITLE Project initialization

:: If command line argument is "-y", then just go on, don't ask.
IF /I "%~1"=="-y" (GOTO :start)

:: If command line argument is --help, then just go on, don't ask.
IF /I "%~1"=="--help" (GOTO :explain) ELSE (GOTO :ask)
:explain
echo.
echo Usage: init-project.bat [OPTION]
echo Initialize a project shell, you need to have 7Zip installed.
echo.
echo -y                 force without confirmation
echo --help             display this help screen

:: Ask people if they really want to proceed
:ask
echo.
SET /P confirm="Are you SURE you want to launch the initialization script? (Y/y/N/n) "
echo.

:: Use that variable prompted from user to go further or not
IF /I "%confirm%"=="y" (GOTO :start) ELSE (GOTO :bypass)

:: Start the initialization of the project
:start

:: Unzip the 7.2.25 version of php to the directory php-sources/php-win64/ of the project
echo ---------------------------------------------------
echo PHP 7.2.25 - Initialization of php
echo ---------------------------------------------------
if exist php-sources/php-win64/php.exe (
    echo PHP is already extracted!
) else (
    echo Starting the extraction of php.
    "C:\Program Files\7-Zip\7z.exe" x php-sources/php-win64.zip -oc:php-sources/php-win64/
)

echo added the file php.ini
copy /Y "./php-sources\php.ini" "./php-sources\php-win64"

:: Install composer to use different plugin
echo .
echo ---------------------------------------------------
echo Composer - self-update and update
echo ---------------------------------------------------

cd devops-sources
echo Update of composer.phar
"../php-sources/php-win64/php.exe" composer.phar self-update

echo .
echo Installation of
echo    * PHP Mess Detector
echo    * PHP Insights
echo    * PHP Cs-fixer
echo    * PHP Sniffer
echo    * PHP Stan
echo by composer into the folder devops-sources
"../php-sources/php-win64/php.exe" composer.phar update
cd ../

:: Git hooks
echo .
echo ---------------------------------------------------
echo Git init
echo ---------------------------------------------------

:: Initialization of git to copy the git hook
if not exist ./.git (
    echo Initialization of git
    git init
) else (
    echo You already have a folder '.git'!
)

echo .
echo ---------------------------------------------------
echo Git hooks - pre-push, pre-commit and commit-msg
echo ---------------------------------------------------

:: Copy of the git hooks into the folder .git\hooks of the project
echo Copy of the folder 'git-hooks-sources' into the folder '.git/hooks' of the project
copy /Y git-hooks-sources\commit-msg .git\hooks
copy /Y git-hooks-sources\pre-commit .git\hooks
copy /Y git-hooks-sources\pre-push .git\hooks

:: Just stop here and go to the end!
GOTO end

:: If the user answered "n"
:bypass
echo OK, then. See you around! :)
echo ---------------------------------------------------

:: The end!
:end