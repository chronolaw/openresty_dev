# Copyright (C) 2018 by chrono
#
# python hello.py
# python hello.py 1>/dev/null 2>&1
# ab -c 100 -n 10000 127.1:8080/

from BaseHTTPServer import HTTPServer, BaseHTTPRequestHandler

class RequestHandler(BaseHTTPRequestHandler):

    def do_GET(self):

        #self.protocal_version = "HTTP/1.1"
        #self.send_header("Content-Type", "text/html")

        self.send_response(200)

        self.end_headers()

        self.wfile.write("hello, world\n")

if __name__ == '__main__':
        serverAddress = ('', 8080)
        server = HTTPServer(serverAddress, RequestHandler)
        server.serve_forever()

