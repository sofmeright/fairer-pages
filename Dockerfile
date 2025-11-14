# syntax=docker/dockerfile:1.7
FROM alpine:3.22

RUN apk add --no-cache nginx ca-certificates tzdata python3 py3-yaml

RUN mkdir -p /var/cache/nginx /var/run/nginx /etc/nginx/conf.d

COPY src/nginx.conf /etc/nginx/nginx.conf
COPY src/default.conf /etc/nginx/conf.d/default.conf
COPY src/index.html /usr/share/nginx/html/index.html
COPY src/banner.html /usr/share/nginx/html/banner.html
COPY src/banner-fantasy.html /usr/share/nginx/html/banner-fantasy.html
COPY Readme.md /usr/share/nginx/html/Readme.md
COPY src/themes/ /usr/share/nginx/html/themes/
COPY default-playlists.yml /usr/share/nginx/html/default-playlists.yml

COPY src/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN chown -R nginx:nginx /usr/share/nginx/html /var/cache/nginx /var/run/nginx

EXPOSE 80

STOPSIGNAL SIGQUIT

ENTRYPOINT ["/entrypoint.sh"]
