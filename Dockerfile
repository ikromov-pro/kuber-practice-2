# ---------- BUILD STAGE ----------
FROM golang:1.22-alpine AS build

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
    go build -o myapp .

# ---------- RUN STAGE ----------
FROM alpine:latest

WORKDIR /app

COPY --from=build /app/myapp /myapp

EXPOSE 8080

CMD ["/myapp"]
