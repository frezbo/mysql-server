#!/bin/sh
set -e
MYSQL_DIR=/var/lib/mysql
import_file=$(mktemp)

if [ ! -d "$MYSQL_DIR/mysql" ]; then
	mysql_install_db --user=root > /dev/null 2>&1 || echo "Database initialization failed"
	if [ ! -z "$MYSQL_ROOT_PASS" ]; then
		cat << EOF > $import_file
			USE mysql;
			UPDATE user SET PASSWORD=PASSWORD("$MYSQL_ROOT_PASS") WHERE User='root';
			DELETE FROM mysql.user WHERE User='';
			DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
			DROP DATABASE IF EXISTS test;
			DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
			FLUSH PRIVILEGES;
EOF
	else
		echo "root password not set"
		exit 1
	fi
	if [ ! -z "$MYSQL_DB_NAME" ]; then
		echo CREATE DATABASE $MYSQL_DB_NAME\; >> "$import_file"
	fi
	if [ ! -z "$MYSQL_DB_USER" -a ! -z "$MYSQL_DB_PASS" ]; then
		echo GRANT ALL ON "$MYSQL_DB_NAME".\* TO \'$MYSQL_DB_USER\'@\'%\' IDENTIFIED BY \'$MYSQL_DB_PASS\'\; >> "$import_file"
	else
		echo "Provide both username and password"
	fi
/usr/bin/mysqld --user=root --bootstrap --verbose=0 < $import_file > /dev/null 2>&1 || echo "Database creation failed"
rm -f "$import_file"
else
	mkdir -p /run/mysqld
	exec /usr/bin/mysqld --user=root --console 
fi