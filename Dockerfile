FROM golang:latest AS builder

ARG TARGETARCH
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=$TARGETARCH

WORKDIR /go/src/github.com/u1aryz/docker-forward-proxy
COPY . .
RUN make

# runtime
FROM gcr.io/distroless/base-debian12
RUN apk add --no-cache ca-certificates
COPY --from=builder /go/src/github.com/u1aryz/docker-forward-proxy/app app
EXPOSE 8080
ENTRYPOINT ["/app"]
CMD []
