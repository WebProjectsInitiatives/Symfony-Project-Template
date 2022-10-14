#!/bin/sh

#############################################################################################################
# symfony-project-template - Windows - Git Hooks - Check the commit-msg syntax                       #

# @author: William Pinaud & Aurélien Tricard                                                  #
#############################################################################################################

# regex to validate in commit message
commitRegex="^((\[(([0-9a-z|\-âéÇêîôûàèùëïü ]{1,})|([A-Z]{1,}-[0-9]{1,}))\])|(WIP:)) .{1,}"
errorMsg="Aborting commit. Your commit message is missing either a JIRA Issue '[EXAMPLE-1111] example' or '[devops] example' or 'WIP: example'"

# check if regex match with the commit msg
if ! grep -E "$commitRegex" "$1"; then
    echo "$errorMsg" >&2
    exit 2
fi