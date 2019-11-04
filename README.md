# docker-forward-proxy

Simple forward proxy.

## Build

```
$ docker build . -t proxy-app
```

## Run

- Simple
```
$ docker run -p 3128:8080 proxy-app
```

- If use basic auth

```
$ docker run -p 3128:8080 proxy-app -user=u1aryz -pass=hogefuga
```

- If change container port

```
$ docker run -p 3128:9090 proxy-app -port=9090
```
