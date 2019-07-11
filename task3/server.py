#!/usr/bin/python3
import socket
import hashlib
import pymysql
from threading import Thread

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

host = ''
port = 5000
address = (host, port)
server_socket.bind(address)
server_socket.listen(100)

total_users = 0
user_details = ""
client_active = 0
clients = {}
addresses = {}


def login(client):
    try:
        global user_details
        global client_active

        user_details = client.recv(1024).decode("utf8")
        user_details = user_details.split(',')
        encrypted_password = hashlib.sha512(user_details[2].encode("utf8")).hexdigest()

        if user_details[1] and user_details[2]:

            sql_server = "localhost"
            sql_user = "userchatsocket"
            sql_user_password = "userchatsocket1!Q"
            sql_database = "chatsocket"
            sql_conn = pymysql.connect(sql_server, sql_user, sql_user_password, sql_database)
            cursor = sql_conn.cursor()

            if user_details[0] == "login":

                sql_stmt = "SELECT * FROM userdetails WHERE username='" + user_details[1] + "' AND password='" + encrypted_password + "';"
                cursor.execute(sql_stmt)
                cursor.fetchall()
                client_active = cursor.rowcount
                if client_active == 0:
                    client.send(bytes("Invalid user credentials \nRestart and Try again", "utf8"))

            elif user_details[0] == "signup":

                sql_stmt = "SELECT * FROM userdetails WHERE username='" + user_details[1] + "';"
                cursor.execute(sql_stmt)
                cursor.fetchall()
                client_active = cursor.rowcount

                if client_active == 0:

                    sql_stmt = "INSERT INTO userdetails VALUES ('" + user_details[1] + "', '" + encrypted_password + "');"
                    cursor.execute(sql_stmt)
                    sql_conn.commit()
                    client.send(bytes("User successfully created \nRestart and login.", "utf8"))
                else:

                    client.send(bytes("Username already exists \nRestart and try with a different username again.", "utf8"))
                    client_active = 0

            else:
                client.send(bytes("Your input is invalid for login or signup action", "utf8"))

            sql_conn.close()

            if client_active:
                client_connection(user_details[1], client)

            else:
                client.send(bytes("disconnected", "utf8"))
                client.close()

        else:
            client.send(bytes("Invalid Credentials \nRestart and Try again", "utf8"))

    except:
        client.send(bytes("Something went wrong on the server \nRestart and Try again", "utf8"))


def send_messages(sender, message):
    for specific_client in clients:

        if (sender != "") and (clients[specific_client] == sender):
            prefix = "You > "
        else:
            prefix = sender + " > "

        send_message = prefix + message + '\n'
        specific_client.send(bytes(send_message, "utf8"))


def client_connection(client_name, client):
    global total_users
    total_users += 1

    welcome_message = "Welcome to the chat! \nType messages and press enter to send \nTo exit enter 'quit' anytime \nTo export chat to text file, enter 'exportmessages' \nNumber of Users online: " + str(
        total_users)
    client.send(bytes(welcome_message, "utf8"))

    message = str(client_name) + " has joined the chat\n Number of Users online: " + str(total_users)
    send_messages(client_name, message)
    clients[client] = client_name

    while True:

        message = client.recv(1024).decode("utf8")
        if message != "quit":
            send_messages(client_name, message)

        else:
            client.close()
            del clients[client]
            del addresses[client]
            total_users = total_users - 1
            send_messages(client_name, str(client_name)+" left the chat \nNumber of Users online: "+str(total_users)+"\n")
            break


def connections():
    while True:
        client, client_address = server_socket.accept()
        addresses[client] = client_address
        Thread(target=login, args=(client,)).start()


new_thread = Thread(target=connections)
new_thread.start()
new_thread.join()

server_socket.close()
