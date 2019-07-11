#!/usr/bin/python3
import socket
import sys
import getpass
from threading import Thread

client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

host = '192.168.101.105'
port = 5000
address = (host, port)
client_socket.connect(address)


login_input = input("Enter 'login' to login or 'signup' to create a new account and press enter: ")
username = input("Enter Username: ")
password = getpass.getpass(prompt="Enter Password: ")

login_message = login_input+"," + username + "," + password
client_socket.send(bytes(login_message, "utf8"))

messages = []


def receive_messages():
    global messages

    while True:
        try:
            received_message = client_socket.recv(1024).decode("utf8")

            if received_message == "disconnected":
                client_socket.close()
                sys.exit()

            else:
                print(received_message)
                messages.append(received_message)

        except OSError:
            print("Disconnected from the server")
            break


def send_messages():
    global messages
    while True:
        send_message = input()

        if send_message == "quit":
            client_socket.send(bytes(send_message, "utf8"))
            client_socket.close()
            sys.exit()

        elif send_message == "exportmessages":
            text_file = open("messages.txt", "w")
            text_file.writelines(messages)
            text_file.close()

        else:
            client_socket.send(bytes(send_message, "utf8"))


Thread(target=receive_messages).start()
Thread(target=send_messages).start()