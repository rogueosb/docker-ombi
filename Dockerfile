FROM mono:4.2.1.102

MAINTAINER rogueosb@gmail.com

ENV APTLIST="bzip2 libcurl4-openssl-dev wget unzip"

# install packages
RUN apt-get update -q && \
apt-get install $APTLIST -qy && \

mkdir /app && \
mkdir /config && \

# clean up
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ADD start.sh /start.sh
RUN chmod +x /start.sh

# ports and volumes
VOLUME /config
EXPOSE 3579

WORKDIR /config

ENTRYPOINT ["/start.sh"]
