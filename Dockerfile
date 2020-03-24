FROM golang:1.13.4-alpine3.10 as go-builder
COPY . /go/src/yuyiwei/prometheus-exporter
RUN apk add --no-cache go dep git musl-dev
RUN go get github.com/prometheus/client_golang/prometheus/promhttp
WORKDIR /go/src/yuyiwei/prometheus-exporter
RUN go build

FROM alpine:3.10
COPY --from=go-builder /go/src/yuyiwei/prometheus-exporter /app/prometheus-exporter
WORKDIR /app/prometheus-exporter
RUN chmod +x ./prometheus-exporter
CMD ./prometheus-exporter

