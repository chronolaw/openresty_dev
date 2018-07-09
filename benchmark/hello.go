// Copyright (C) 2018 by chrono
//
// sudo apt-get install golang-go
// go version
//
// go build hello.go

package main

import (
    "net/http"
    )

func hello(resp http.ResponseWriter, req *http.Request) {
        resp.Write([]byte("hello, world\n"))
}

func main() {
    http.HandleFunc("/", hello)
    http.ListenAndServe(":8080", nil)
}
