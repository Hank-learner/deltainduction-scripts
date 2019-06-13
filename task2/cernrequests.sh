#! /bin/bash -x

sudo mysql -u root -p
#code inside mysql
CREATE DATABASE CERNrequests;
USE CERNrequests;

CREATE TABLE nodes(
Name VARCHAR(20) not null,
Number_of_CPU  INT unsigned not null,
Available_CPU INT unsigned not null,
Memory_size FLOAT unsigned not null,
Available_memory FLOAT unsigned not null
);

INSERT INTO nodes VALUES('agate',16,14,118,110);
INSERT INTO nodes VALUES('coral',16,15,58,52);
INSERT INTO nodes VALUES('diamond',24,22,116,106);
INSERT INTO nodes VALUES('jade',32,30,236,220);


CREATE TABLE requests(
ID INT UNSIGNED not null,
allocated_node_name VARCHAR(20) not null,
start_time DATETIME not null,
CPU_required INT unsigned not null,
Memory_required FLOAT not null,
time_required_for_completion INT unsigned not null
);
#exit out of mysql
exit;

sudo su


mkdir -p /var/www/loadbalancer.com/public_html
chown -R $USER:$USER /var/www/loadbalancer.com/public_html
chmod -R 755 /var/www/loadbalancer.com/public_html
cd /var/www/loadbalancer.com/public_html
gedit /var/www/loadbalancer.com/public_html/index.html
#code inside for index.html
gedit /var/www/loadbalancer.com/public_html/loadbalancer.php
#code inside for loadbalancer.php
cd /etc/apache2/sites-available
cp 000-default.conf  loadbalancer.com.conf

echo "<VirtualHost *:81> 
ServerAdmin info@loadbalancer.com
ServerName loadbalancer.com
ServerAlias www.loadbalancer.com  #website in internet
DocumentRoot /var/www/loadbalancer.com/public_html
ErrorLog ${APACHE_LOG_DIR}/error.log
CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" >loadbalancer.com.conf

a2ensite loadbalancer.com.conf

nano /etc/hosts
#adding ip address and website name


mkdir -p /var/www/agate.com/public_html
chown -R $USER:$USER /var/www/agate.com/public_html
chmod -R 755 /var/www/agate.com/public_html
gedit /var/www/agate.com/public_html/index.php
#code inside for index.php from agate.php
cd /etc/apache2/sites-available
cp 000-default.conf  agate.com.conf   #inside /etc/apache2/sites-available

echo "<VirtualHost *:82> 
ServerAdmin info@agate.com
ServerName agate.com
ServerAlias www.agate.com  #website in internet
DocumentRoot /var/www/agate.com/public_html
ErrorLog ${APACHE_LOG_DIR}/error.log
CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" >agate.com.conf

a2ensite agate.com.conf

nano /etc/hosts
#adding ip address and server name


mkdir -p /var/www/coral.com/public_html
chown -R $USER:$USER /var/www/coral.com/public_html
chmod -R 755 /var/www/coral.com/public_html
gedit /var/www/coral.com/public_html/index.php
#code inside for index.php from coral.php
cp 000-default.conf  coral.com.conf   #inside /etc/apache2/sites-available

echo "<VirtualHost *:83> 
ServerAdmin info@coral.com
ServerName coral.com
ServerAlias www.coral.com  #website in internet
DocumentRoot /var/www/coral.com/public_html
ErrorLog ${APACHE_LOG_DIR}/error.log
CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" >coral.com.conf

a2ensite coral.com.conf

nano /etc/hosts
#adding ip address and server name


mkdir -p /var/www/diamond.com/public_html
chown -R $USER:$USER /var/www/diamond.com/public_html
chmod -R 755 /var/www/diamond.com/public_html
gedit /var/www/diamond.com/public_html/index.php
#code inside for index.php from diamond.php
cp 000-default.conf  diamond.com.conf  #inside /etc/apache2/sites-available

echo "<VirtualHost *:84> 
ServerAdmin info@diamond.com
ServerName diamond.com
ServerAlias www.diamond.com  #website in internet
DocumentRoot /var/www/diamond.com/public_html
ErrorLog ${APACHE_LOG_DIR}/error.log
CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" >diamond.com.conf

a2ensite diamond.com.conf

nano /etc/hosts
#adding ip address and server name


mkdir -p /var/www/jade.com/public_html
chown -R $USER:$USER /var/www/jade.com/public_html
chmod -R 755 /var/www/jade.com/public_html
gedit /var/www/jade.com/public_html/index.php
#code inside for index.php from jade.php
cp 000-default.conf  jade.com.conf  #inside /etc/apache2/sites-available

echo "<VirtualHost *:85> 
ServerAdmin info@jade.com
ServerName jade.com
ServerAlias www.jade.com  #website in internet
DocumentRoot /var/www/jade.com/public_html
ErrorLog ${APACHE_LOG_DIR}/error.log
CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" >jade.com.conf

a2ensite jade.com.conf

nano /etc/hosts
#adding ip address and server name


service apache2 restart


































#creating files for server
sudo chmod 755 /var/www/html
sudo touch /var/www/html/agate.php
sudo touch /var/www/html/coral.php
sudo touch /var/www/html/diamond.php
sudo touch /var/www/html/jade.php

sudo gedit /var/www/html/index.html
sudo gedit /var/www/html/loadbalancer.php

sudo gedit /var/www/html/agate.php
sudo gedit /var/www/html/coral.php
sudo gedit /var/www/html/diamond.php
sudo gedit /var/www/html/jade.php
#adding code to each one of these from each of the respective php files