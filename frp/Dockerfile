ARG BUILD_FROM
FROM $BUILD_FROM
MAINTAINER SchumyHao <schumy.haojl@gmail.com>

ENV LANG C.UTF-8

ARG BUILD_ARCH
ARG FRP_VERSION=0.14.0
#RUN apk update \
#    && apk add ca-certificates wget \
#    && update-ca-certificates
RUN apk add --no-cache jq

#WORKDIR /tmp
RUN set -x \
    && wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_${BUILD_ARCH}.tar.gz \
    && tar -zxf frp_${FRP_VERSION}_linux_${BUILD_ARCH}.tar.gz \
    && mv frp_${FRP_VERSION}_linux_${BUILD_ARCH} /var/frp \
    && mkdir -p /var/frp/conf

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
