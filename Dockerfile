FROM golang:1.18-alpine AS builder

RUN apk add --no-cache git

RUN go install filippo.io/mkcert@latest

FROM alpine

COPY --from=builder /go/bin/mkcert /usr/local/bin/mkcert

RUN adduser --disabled-password app

USER app

RUN mkdir -p /home/app/.local/share/mkcert/

WORKDIR /home/app/.local/share/mkcert

CMD ["mkcert"]
