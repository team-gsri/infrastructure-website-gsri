FROM tdewolff/minify:v2.20.20@sha256:eb79a7f8ff8110c8eb3cc623ec6d60cfed668222411af5d8bb13c3478717abe2 AS minifier
WORKDIR /src/homepage
COPY *.html .
COPY *.css .
RUN find . -exec minify -o {} {} \;

FROM nginxinc/nginx-unprivileged:1.25.2-alpine-slim@sha256:ab90b7a54c4a0de4fc94ad0af201674c4379dde5ee1153606f0241c11063a8ad AS build
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
WORKDIR /usr/share/nginx/html
COPY img img
COPY lib lib
COPY favicon.ico .
COPY --from=minifier /src/homepage .
COPY *.txt .