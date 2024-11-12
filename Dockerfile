FROM golang:1.22.9 AS builder


ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64


WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

RUN go mod tidy

COPY . .

RUN go build -o movie-reservation-system



FROM gcr.io/distroless/base-debian11

COPY --from=builder /app/movie-reservation-system .


CMD ["./movie-reservation-system"]