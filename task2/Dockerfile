FROM nginx:1.28.0

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/conf.d/

COPY ssl/selfsigned.crt /etc/ssl/certs/

COPY ssl/selfsigned.key /etc/ssl/private/

COPY html /usr/share/nginx/html

EXPOSE 80 443