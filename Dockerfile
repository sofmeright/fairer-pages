# syntax=docker/dockerfile:1.7
FROM alpine:3.22

RUN apk add --no-cache nginx ca-certificates tzdata

RUN mkdir -p /var/cache/nginx /var/run/nginx /etc/nginx/conf.d

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/index.html
COPY banner.html /usr/share/nginx/html/banner.html
COPY banner-fantasy.html /usr/share/nginx/html/banner-fantasy.html
COPY Readme.md /usr/share/nginx/html/Readme.md
COPY themes/ /usr/share/nginx/html/themes/

RUN chown -R nginx:nginx /usr/share/nginx/html /var/cache/nginx /var/run/nginx

EXPOSE 80

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
