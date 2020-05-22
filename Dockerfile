FROM ubuntu:18.04

RUN apt-get update\
    && apt-get install --no-install-recommends -y apache2=2.4.29*\
    && apt-get clean\
    && rm -rf /var/lib/apt/lists/*

COPY app /var/www/html/

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]