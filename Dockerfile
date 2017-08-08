FROM golang:1.7 as builder
WORKDIR /go/src/github.com/ekristen/docker-plugin-multilogger
COPY . /go/src/github.com/ekristen/docker-plugin-multilogger
RUN go build --ldflags '-extldflags "-static"' -o /usr/bin/multilogger

FROM ubuntu
RUN mkdir -p /run/docker/plugins
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/bin/multilogger /usr/bin/multilogger
RUN chmod +x /usr/bin/multilogger
