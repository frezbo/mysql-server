#MySQL server based on Alpine Linux [![Build Status](https://travis-ci.org/frezbo/mysql-server.svg?branch=master)](https://travis-ci.org/frezbo/mysql-server)

## Instructions

1. docker pull frezbo/mysql-server </br>
2. docker run --rm -v /opt/data:/var/lib/mysql -e MYSQL_ROOT_PASS=root_pw -e MYSQL_DB_NAME=db -e MYSQL_DB_USER=db_user -e MYSQL_DB_PASS=db_pass frezbo/mysql-server </br>
3. docker run -d  --name msql -v /opt/data:/var/lib/mysql frezbo/mysql-server </br>

Change the volume directory and db parameters as required

####NB: Database cannot be crated without a root password and extra databases paramters must be passed while creating the database