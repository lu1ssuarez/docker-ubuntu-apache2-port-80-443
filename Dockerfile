FROM ubuntu:18.04

LABEL maintainer="support@luewell.com"

MAINTAINER support@luewell.com

EXPOSE 80
EXPOSE 443

RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install -y software-properties-common curl wget git zip unzip apt-utils htop nano bash-completion sudo
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y apache2 && service apache2 restart

RUN a2enmod rewrite headers ssl proxy proxy_http proxy_wstunnel && service apache2 restart

RUN chown -R $USER:www-data /var/www && chmod -R 755 /var/www && rm /var/www/html/index.html

WORKDIR /var/www/html

CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
