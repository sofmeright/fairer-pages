# syntax=docker/dockerfile:1.7
FROM alpine:3.22

RUN apk add --no-cache nginx ca-certificates tzdata python3 py3-yaml

RUN mkdir -p /var/cache/nginx /var/run/nginx /etc/nginx/conf.d

COPY src/nginx.conf /etc/nginx/nginx.conf
COPY src/default.conf /etc/nginx/conf.d/default.conf
COPY --chown=nginx:nginx src/index.html /usr/share/nginx/html/index.html
COPY --chown=nginx:nginx src/banner.html /usr/share/nginx/html/banner.html
COPY --chown=nginx:nginx src/banner-fantasy.html /usr/share/nginx/html/banner-fantasy.html
COPY --chown=nginx:nginx Readme.md /usr/share/nginx/html/Readme.md
COPY --chown=nginx:nginx src/themes/ /usr/share/nginx/html/themes/
COPY --chown=nginx:nginx default-playlists.yml /usr/share/nginx/html/default-playlists.yml

COPY src/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && chown -R nginx:nginx /var/cache/nginx /var/run/nginx

EXPOSE 80

STOPSIGNAL SIGQUIT

ENTRYPOINT ["/entrypoint.sh"]
