// Copyright (C) 2018 by chrono
//
// sudo apt-get install nodejs
// nodejs -v
//
// nodejs hello.js
// ab -c 100 -n 10000 127.1:8080/

var http = require('http')

http.createServer(
    function(request, response)
    {
        response.writeHead(200, {'Content-Type': 'text/plain'});

        response.end('hello, world\n');
    }
).listen(8080);
