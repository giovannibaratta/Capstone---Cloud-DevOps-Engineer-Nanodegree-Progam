FROM nginx:1.18.0

COPY app /usr/share/nginx/html

EXPOSE 80