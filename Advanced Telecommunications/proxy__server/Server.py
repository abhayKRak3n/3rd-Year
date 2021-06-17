import socket
import tkinter
from datetime import datetime
from enum import Enum
from queue import Queue
from threading import Thread
from tkinter import *


# initialising constant variables
SOCKET_PORT = 8080
SOCKET_BL = 100
DATA_SIZE = 16384
HTTP_PORT = 80
HTTPS_PORT = 443
HTTPS_CONN = "HTTP/1.1 200 Connection established\r\n\r\n"

blacklist = set()   # a list to store blocked sites and URLs
cache = {}
req_queue = Queue()



def _init_UI():
    ui = tkinter.Tk()
    ui.geometry("800x600")

    inp_box = Entry(ui)
    inp_box.pack(fill = X, padx = 10, pady = 5)
    block_list = Listbox(ui, font = ("Consolas",10)) #can change here
    block_list.pack(fill = X, padx = 10, pady = 5)

    # initialising functions to block and unblock urls
    def _block():
        url = inp_box.get()
        if url not in blacklist:
            blacklist.add(url)
            block_list.insert(END, url)
        inp_box.delete(0,END)

    def _unblock():
        i = block_list.curselection()[0]
        url = block_list.get(i)
        block_list.delete(i)
        if url in blacklist:
            blacklist.remove(url)

def main():
    # starting a thread and binding a socket to a port
    Thread(target=_init_UI, args=()).start()

    # creating a TCP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.bind(('', SOCKET_PORT))
    sock.listen(SOCKET_BL)

    # accepts connections from client
    try:
        while True:
            client_connection, client_address = sock.accept()
            Thread(target = request_thread, args= (client_connection, )).start()
    finally:
        sock.close()


    # initialising buttons
    block_btn = Button(ui, text="Block", command=_block)
    block_btn.pack(fill = X, padx=10, pady = 5)
    unblock_btn = Button(ui, text="Block", command=_unblock)
    unblock_btn.pack(fill = X, padx=10, pady=5)

    # initialising connection box ui
    #change values
    connection_box = Listbox(ui, font = ("Consolas",10))
    connection_box.pack(fill = BOTH, padx = 10, pady = 10, expand = 1)

    # adding each item in display to the connection box
    while True:
        while not req_queue.empty():
            connection_box.insert(0, req_queue.get())
        ui.update_idletasks()
        ui.update()


# log a request to display queue
def log_request(request):
    req_queue.put(str(request))


# function to handle a request from client
def request_thread(client_conn):
    data = client_conn.recv(DATA_SIZE)
    request = proxy_request(data)

    request.is_blocked = request.url in blacklist   # checks if request is blocked or not
    if request.is_blocked:
        log_request(request)
    else:
        if request.request_type == proxy_request_type.Http:   # checks if request is http
            handle_http_request(client_conn, request)
            log_request(request)
        else:
            log_request(request)            # checks if request is https
            handle_https_request(client_conn, request)


# handler for HTTP request
def handle_http_request(client_conn, request):
    request.is_cached = request.url in cache

    if request.is_cached:
        client_conn.sendall(cache[request.url])  # if request is cached then send back to client
    else:
        server_conn = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        server_conn.connect((request.url, request.port))
        server_conn.send(request.data)
        server_conn.settimeout(1)  # sets timeout for a limited period
        response = bytearray()

        try:                    # receive response and send a response back to client
            while True:
                segment = server_conn.recv(DATA_SIZE)
                if len(segment):
                    client_conn.send(segment)
                    response.extend(segment)
                else:
                    break
        except socket.error:
            pass

        # close the connections
        server_conn.close()
        client_conn.close()
        cache[request.url] = response  # cache the response

    request.end()


# handler for HTTPS request
def handle_https_request(client_conn, request):
    server_conn = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_conn.connect((request.url, request.port))
    client_conn.sendall(HTTPS_CONN.encode())  # confirms https connection to client

    server_conn.setblocking(False)
    client_conn.setblocking(False)

    while True:
        # relaying data from client to server
        try:
            data = client_conn.recv(DATA_SIZE)
            server_conn.sendall(data)
        except socket.error:
            pass
        # relaying data from server to client
        try:
            data = server_conn.recv(DATA_SIZE)
            client_conn.sendall(data)
        except socket.error:
            pass



# class for a request object type
class proxy_request:

    # initialise
    def __init__(self, data):
        self.data = data
        data_string = str(data)
        self.blocked = False
        self.cached = False

        line=data_string.splitlines()[0]
        method=line.split(' ')[0]
        raw_url=line.split(' ')[1]

        # if request type is connect
        self.request_type = proxy_request_type.Https if "CONNECT" in method.upper() else proxy_request_type.Http

        self.url, self.port = self.parse_url(raw_url)   # init timestamp and url
        self.start_date = datetime.now().strftime("%H:%M:%S")
        self.start_timestamp = datetime.now().microsecond
        self.end_timestamp = self.start_timestamp       #change name

    def __str__(self):
        req_type = "HTTP " if self.request_type == proxy_request_type.Http else "HTTPS"
        blocked = "BLOCKED" if self.blocked else "ALLOWED"
        duration = round(abs(self.end_timestamp - self.start_timestamp) / 1000, 2)
        cache_text = f"(cached: {duration}ms)" if self.cached else f"(uncached: {duration}ms)"

        if self.request_type == proxy_request_type.Http and not self.blocked:
            return f"{self.start_date} - {req_type} - {blocked} - {self.url} {cache_text}"
        else:
            return f"{self.start_date} - {req_type} - {blocked} - {self.url}"

    def end(self):
        self.end_timestamp = datetime.now().microsecond

    # function to parse and extract url
    def parse_url(self, url):

        if url.startswith("https://"):
            url = url[8:]
        elif url.startswith("http://"):
            url = url[7:]

        port_start = url.find(":")
        port_end = url.find("/")
        if port_end == -1:
            port_end = len(url)

        if port_start == -1 or port_end < port_start:
            port = 80
            url = url[:port_end]
        else:
            start_i, end_i = port_start + 1, port_end - port_start - 1
            port = int(url[start_i:][:end_i])
            url = url[:port_start]

        return url, port


class proxy_request_type(Enum):
    Http = 1
    Https = 2


if __name__ == "__main__":
    main()

