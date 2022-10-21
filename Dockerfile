FROM alpine:3.13
MAINTAINER Fabian Beuke <mail@beuke.org>

RUN apk add --update --no-cache \
    libgcc libstdc++ libx11 glib libxrender libxext libintl \
    ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family \
    font-jis-misc font-noto font-noto-cjk font-noto-thai font-jis-misc \
    font-isas-misc font-noto-devanagari font-noto-arabic \
    font-noto-malayalam font-noto-tamil font-noto-kannada font-noto-telugu \
    font-noto-oriya font-noto-gujarati font-noto-bengali

# On alpine static compiled patched qt headless wkhtmltopdf (46.8 MB).
COPY --from=madnight/alpine-wkhtmltopdf-builder:0.12.5-alpine3.10-606718795 \
    /bin/wkhtmltopdf /bin/wkhtmltopdf
RUN [ "$(sha256sum /bin/wkhtmltopdf | awk '{ print $1 }')" \
        == "06139f13500db9b0b4373d40ff0faf046e536695fa836e92f41d829696d6859f" ]

ENTRYPOINT ["wkhtmltopdf"]
