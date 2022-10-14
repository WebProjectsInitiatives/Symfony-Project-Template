#!/bin/sh

#############################################################################################################
# symfony-project-template - Windows - Git Hooks - Launch an analyse of PHP-Stan                     #

# @author: William Pinaud & Aurélien Tricard                                                  #
#############################################################################################################

echo "PHP-STAN pre-push hook start"
echo ""

# Path to the PHP-STAN's executable
phpStan="devops-sources/vendor/bin/phpstan"

# Check if PHP-STAN is install
exec < /dev/tty

if [[ -x devops-sources/vendor/bin/phpstan ]]; then
    phpFiles=$(git diff --name-only --diff-filter=d HEAD | grep -e '\.php'|cut -d' ' -f3)

    if [[ "$phpFiles" != "" ]]; then
        ${phpStan} analyze -c devops-sources/phpstan.neon --memory-limit 4G ${phpFiles}
        test=$?

        if [[ "$test" != "0" ]]; then
            echo ""
            read -p 'Êtes-vous sur de vouloir push, il reste encore des erreurs détectées par PHP-Stan? [y/n](n):' proceed
            if [[ "$proceed" != 'y' ]]; then
                 echo ""
                 echo "The push has been stopped"
                 echo ""
                 exit 1
            fi
        fi
    else
        echo ""
        echo "Aucun fichier php n'a été modifié lors de ce push!"
        echo ""
    fi
else
    echo ""
    echo "Aborting push. Please config your IDE as explain in the README and launch the script of the initialization of the project."
    echo ""
    exit 1;
fi

echo ""
echo "PHP-STAN pre-push hook finish"