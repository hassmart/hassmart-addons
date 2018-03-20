ARG BUILD_FROM
FROM $BUILD_FROM
MAINTAINER SchumyHao <schumy.haojl@gmail.com>

ENV LANG C.UTF-8

WORKDIR /usr/src/rhome-bridge

USER root

ARG BUILD_ARCH
ARG RHOME_VERSION=1.6.0

RUN apt-get update && apt-get install -y bash jq wget curl && \
    URL_VERSION="https://raw.githubusercontent.com/hassmart/hassmart-addons/master/version.json" && \
    RHOME_VERSION=$(curl -s $URL_VERSION | jq -e -r '.rhome') && \
    npm install -g homebase-hass-bridge@{$RHOME_VERSION}

EXPOSE 9999

COPY run.sh /
RUN chmod a+x /run.sh
CMD [ "/run.sh" ]
