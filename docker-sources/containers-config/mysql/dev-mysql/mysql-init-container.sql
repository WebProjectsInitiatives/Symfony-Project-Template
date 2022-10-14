#####################################################################################
# symfony-project-template - MySQL - Dev SQL Configuration File                     #
# @author: Willam Pinaud & Aurélien Tricard                                         #
#####################################################################################

# Connection to the table mysql
USE mysql;

# Change caching_sha2_password to mysql_native_password for symfony-project-template
ALTER USER '%MYSQL_USER%'@'localhost' IDENTIFIED WITH mysql_native_password BY '%MYSQL_PASSWORD%';
ALTER USER '%MYSQL_USER%'@'%' IDENTIFIED WITH mysql_native_password BY '%MYSQL_PASSWORD%';

ALTER USER '%MYSQL_USER%'@'localhost' IDENTIFIED BY '%MYSQL_PASSWORD%';
ALTER USER '%MYSQL_USER%'@'%' IDENTIFIED BY '%MYSQL_PASSWORD%';