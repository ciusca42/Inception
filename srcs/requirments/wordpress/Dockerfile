FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

# install php-fpm, curl, mysql php bindings and netcat for healthcheck
RUN apt-get install -y php-fpm curl php-mysql netcat

COPY tools/configure_script.sh /

RUN chmod +x /configure_script.sh

COPY tools/wp-config.php /

CMD [ "/configure_script.sh" ]


