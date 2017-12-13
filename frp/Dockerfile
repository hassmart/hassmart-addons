ARG BUILD_FROM
FROM $BUILD_FROM
MAINTAINER SchumyHao <schumy.haojl@gmail.com>

ENV LANG C.UTF-8

ARG BUILD_ARCH
ARG FRP_VERSION=0.14.0
ARG FRP_ARCH="arm"
RUN apk update \
     && apk add --no-cache jq wget

RUN set -x \
    && if [ $BUILD_ARCH == "armhf" ]; then FRP_ARCH="arm"; fi \
    && if [ $BUILD_ARCH == "amd64" ]; then FRP_ARCH="amd64"; fi \
    && if [ $BUILD_ARCH == "i386" ]; then FRP_ARCH="386"; fi \
    && wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_${FRP_ARCH}.tar.gz \
    && tar -zxf frp_${FRP_VERSION}_linux_${FRP_ARCH}.tar.gz \
    && mv frp_${FRP_VERSION}_linux_${FRP_ARCH} /var/frp \
    && mkdir -p /var/frp/conf

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
