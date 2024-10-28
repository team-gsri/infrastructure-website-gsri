FROM dcycle/purgecss:1 AS purger
WORKDIR /src/homepage
COPY www .
RUN find . -name "*.css" -exec purgecss --css {} --content *.html **/*.js --output {} \;

FROM tdewolff/minify:v2.20.20@sha256:eb79a7f8ff8110c8eb3cc623ec6d60cfed668222411af5d8bb13c3478717abe2 AS minifier
WORKDIR /src/homepage
COPY --from=purger /src/homepage /src/homepage
RUN for ext in "css" "js" "html"; do find . -name "*.$ext" -exec minify -o {} {} \;; done
RUN for ext in "css" "js" "html" "png" "webp" "woff2"; do find . -name "*.$ext" -exec gzip -9k {} \;; done

FROM nginxinc/nginx-unprivileged:1.25.2-alpine-slim@sha256:ab90b7a54c4a0de4fc94ad0af201674c4379dde5ee1153606f0241c11063a8ad AS build
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=minifier /src/homepage /usr/share/nginx/html
