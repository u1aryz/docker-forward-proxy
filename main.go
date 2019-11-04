package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"

	"github.com/elazarl/goproxy"
	"github.com/elazarl/goproxy/ext/auth"
)

var (
	portNumber    = flag.Int("port", 8080, "port number")
	basicAuthUser = flag.String("user", "", "basic auth user name")
	basicAuthPass = flag.String("pass", "", "basic auth user pass")
)

func main() {
	flag.Parse()
	proxy := goproxy.NewProxyHttpServer()
	proxy.Verbose = true

	// If use basic auth
	if *basicAuthUser != "" && *basicAuthPass != "" {
		auth.ProxyBasic(proxy, "RELM", func(user, pass string) bool {
			return user == *basicAuthUser && pass == *basicAuthPass
		})
	}
	log.Println("Start proxy...")
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", *portNumber), proxy))
}
