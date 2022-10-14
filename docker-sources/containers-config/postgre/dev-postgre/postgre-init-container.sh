#####################################################################################
# symfony-project-template - MySQL - Dev SQL Configuration File              #

# @author: William Pinaud & Aurélien Tricard                                       #
#####################################################################################

#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER docker;
    CREATE DATABASE docker;
    GRANT ALL PRIVILEGES ON DATABASE symfony-project-template TO docker;
EOSQL
