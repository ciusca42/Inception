FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y php-fpm

RUN apt install curl -y  php-mysql -y

COPY tools/configure_script.sh /

COPY tools/wp-config.php /

CMD [ "./conifgure_script.sh" ]


