# https://hub.docker.com/_/nginx/
# docker build -t epflsi/payonline2024 .
# docker run --rm --name payonline2024 -d -p 80:80 epflsi/payonline2024
FROM nginx:1.27
COPY *.html /usr/share/nginx/html/
