FROM mono:4.4.0.182

MAINTAINER rogueosb@gmail.com

ENV APTLIST="bzip2 libcurl4-openssl-dev wget unzip sqlite3 python2.7"

# install packages
RUN apt-get update -q && \
apt-get install $APTLIST -qy && \
mozroots --import --ask-remove && \

mkdir /app && \
mkdir /config && \

# clean up
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ADD start.sh /start.sh
ADD get-dev.py /get-dev.py
RUN chmod +x /start.sh

# ports and volumes
VOLUME /config
EXPOSE 3579

WORKDIR /config

ENTRYPOINT ["/start.sh"]
