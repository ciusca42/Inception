FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

RUN apt install php-fpm -y

RUN apt install curl -y  php-mysql -y

COPY tools/configure_script.sh /

RUN chmod +x /configure_script.sh

COPY tools/wp-config.php /

CMD [ "/configure_script.sh" ]


