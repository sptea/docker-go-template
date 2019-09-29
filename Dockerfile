FROM golang:latest as builder

ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
WORKDIR /tmp/build
COPY . .
RUN make

FROM alpine
RUN apk add --no-cache ca-certificates
COPY --from=builder /tmp/build/app /app
ENTRYPOINT ["/app"]
