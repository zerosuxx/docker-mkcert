FROM golang:1.18-alpine AS builder

RUN apk add --no-cache git

WORKDIR /go/src

RUN git clone https://github.com/FiloSottile/mkcert

WORKDIR /go/src/mkcert

RUN sed -i 's/"mkcert development CA"/os.Getenv("CA_CERT_ORGANIZATION")/g; \
  s/"mkcert development certificate"/os.Getenv("CLIENT_CERT_ORGANIZATION")/g' cert.go

RUN go build

FROM alpine

COPY --from=builder /go/src/mkcert/mkcert /usr/local/bin/mkcert

RUN adduser --disabled-password app

USER app

RUN mkdir -p /home/app/.local/share/mkcert/

WORKDIR /home/app/.local/share/mkcert

ENV CA_CERT_ORGANIZATION="example ca cert"
ENV CLIENT_CERT_ORGANIZATION="example client cert"

CMD ["mkcert"]
