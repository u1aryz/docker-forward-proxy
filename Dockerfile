FROM golang:latest as builder

ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64

WORKDIR /go/src/github.com/u1aryz/docker-forward-proxy
COPY . .
RUN make

# runtime
FROM alpine
RUN apk add --no-cache ca-certificates
COPY --from=builder /go/src/github.com/u1aryz/docker-forward-proxy/app app
EXPOSE 8080
ENTRYPOINT ["/app"]
CMD []
