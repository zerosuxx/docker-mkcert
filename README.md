# docker-mkcert

## Usage
```shell
docker run -v $PWD:/home/app/.local/share/mkcert/ zerosuxx/mkcert:latest sh -c "mkcert -install && mkcert -cert-file local-cert.pem -key-file local-key.pem docker.localhost *.docker.localhost"
```
