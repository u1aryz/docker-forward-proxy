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
COPY --from=builder /go/src/github.com/u1aryz/docker-forward-proxy/app app
ENTRYPOINT ["/app"]
CMD []
