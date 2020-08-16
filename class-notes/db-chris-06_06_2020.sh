# Start DB-1 from AWS-RDS
# Start DB-2 from AWS-RDS
#Connect DB-1 from Workbench
#Download the database sql.zip
#Extract zip file
#Copy create-databases.sql -> Workbench Query Editor
#Execute the query
#connect to EC2 instance
-----------------------   DB-1 DUMP DATABASES ------------------
#connect to db-1
mysql -u admin -h [db-url] -p
#Dump database from DB-1
mysqldump -u admin -h [db-url] -p [db-name] > [db-name].sql
mysqldump -u admin -h database-1.cbanmzptkrzf.us-east-1.rds.amazonaws.com -p sql_hr > sql_hr.sql
mysqldump -u admin -h database-1.cbanmzptkrzf.us-east-1.rds.amazonaws.com -p sql_inventory > sql_inventory.sql
mysqldump -u admin -h database-1.cbanmzptkrzf.us-east-1.rds.amazonaws.com -p sql_invoicing > sql_invoicing.sql
mysqldump -u admin -h database-1.cbanmzptkrzf.us-east-1.rds.amazonaws.com -p sql_store > sql_store.sql
-----------------------   DB-2 RESTORE DATABASES ------------------
#connect to db-2
mysql -u admin -h [db-url] -p
CREATE DATABASE sql_hr;
CREATE DATABASE sql_inventory;
CREATE DATABASE sql_invoicing;
CREATE DATABASE sql_store;
quit;
#Restore dbs
mysql -u admin -h [db-url] -p [db-name] < [db-name].sql 
mysql -u admin -h database-2.cbanmzptkrzf.us-east-1.rds.amazonaws.com -p sql_hr < sql_hr.sql
mysql -u admin -h database-2.cbanmzptkrzf.us-east-1.rds.amazonaws.com -p sql_inventory < sql_inventory.sql
mysql -u admin -h database-2.cbanmzptkrzf.us-east-1.rds.amazonaws.com -p sql_invoicing < sql_invoicing.sql
mysql -u admin -h database-2.cbanmzptkrzf.us-east-1.rds.amazonaws.com -p sql_store < sql_store.sql