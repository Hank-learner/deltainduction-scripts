#!/usr/bin/python3
import pymysql

sqlhost = "localhost"
sqluser = "root"
sqlpassword = "Your Password here"

conn = pymysql.connect(sqlhost, sqluser, sqlpassword)
cursor = conn.cursor()

sqlstmt = "CREATE DATABASE chatsocket;"
cursor.execute(sqlstmt)

sqlstmt = "USE chatsocket;"
cursor.execute(sqlstmt)

sqlstmt = "CREATE TABLE userdetails ( username varchar(30) NOT NULL, password varchar(255) NOT NULL );"
cursor.execute(sqlstmt)

sqlstmt = "CREATE USER 'userchatsocket'@'localhost' IDENTIFIED BY 'userchatsocket1!Q';"
cursor.execute(sqlstmt)

sqlstmt = "GRANT ALL PRIVILEGES ON chatsocket . * TO 'userchatsocket'@'localhost';"
cursor.execute(sqlstmt)

sqlstmt = "FLUSH PRIVILEGES;"
cursor.execute(sqlstmt)

conn.close()

