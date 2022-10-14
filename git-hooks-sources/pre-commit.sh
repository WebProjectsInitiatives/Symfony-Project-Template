#!/bin/sh

#############################################################################################################
# symfony-project-template - Windows - Git Hooks - Launch PHP-cs-fixer to fix code                   #

# @author: William Pinaud & Aurélien Tricard                                                  #
#############################################################################################################

echo "php-cs-fixer pre-commit hook start"

#Path to the PHP-CS-Fixer's executable
phpCsFixer="devops-sources/vendor/bin/php-cs-fixer"

#Check if devops-sources/vendor/bin/php-cs-fixer exist
if [[ -x devops-sources/vendor/bin/php-cs-fixer ]]; then

    # Fix code's line and add the modified lines
    git status --porcelain | grep -e '^[AM]\(.*\).php$' | cut -c 3- | while read line; do
        ${phpCsFixer} fix --config=./devops-sources/.php_cs.dist.php --verbose --show-progress=estimating "$line";
        git add "$line";
    done

else
    echo ""
    echo "Aborting commit. Please config your IDE as explain in the README and launch the script of the initialization of the project."
    echo ""
    exit 1
fi

echo "php-cs-fixer pre-commit hook finish"
