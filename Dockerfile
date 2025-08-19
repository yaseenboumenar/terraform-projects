FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

COPY install-wordpress.sh /install-wordpress.sh
RUN chmod +x /install-wordpress.sh

RUN apt-get update && \
    apt-get install -y apache2 php php-mysql libapache2-mod-php mysql-client unzip curl && \
    /install-wordpress.sh && \
    rm -f /etc/ssl/private/ssl-cert-snakeoil.key

EXPOSE 80
CMD [ "apachectl", "-D", "FOREGROUND" ]