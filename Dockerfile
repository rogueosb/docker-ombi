
FROM microsoft/dotnet:2.1-runtime

MAINTAINER rogueosb@gmail.com

ENV APTLIST="bzip2 libcurl4-openssl-dev wget python"

# install packages
RUN apt-get update -q && \
apt-get install $APTLIST -qy && \
mkdir /app && \
mkdir /config && \
curl -o \
 /tmp/s6-overlay.tar.gz -L \
	"https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.5/s6-overlay-amd64.tar.gz" && \
 tar xfz \
	/tmp/s6-overlay.tar.gz -C / && \
# clean up
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

RUN useradd -u 9001 -U -d /config -s /bin/false ombi && \
usermod -G users ombi

ADD start.sh /start.sh
ADD get-dev.py /get-dev.py
ADD get-eap.py /get-eap.py
RUN chmod +x /start.sh

# ports and volumes
VOLUME /config
EXPOSE 3579

WORKDIR /config

ENTRYPOINT ["/init"]
CMD ["/start.sh"]
