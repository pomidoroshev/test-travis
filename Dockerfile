FROM golang:1.10.1

WORKDIR /go/src/app

COPY . .

RUN go get -v ./...
RUN CGO_ENABLED=0 GOOS=linux go build -installsuffix cgo -o bin/main .

FROM alpine:latest
RUN apk --no-cache add ca-certificates

RUN mkdir /app
WORKDIR /app

COPY --from=0 /go/src/app/bin/main .

EXPOSE 8080

CMD ["./main"]
