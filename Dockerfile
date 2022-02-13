FROM nginx:alpine
RUN apk update --no-cache && \
    apk upgrade --no-cache && \
    apk add --no-cache openssl

COPY rootfs /

EXPOSE 80
