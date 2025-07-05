FROM debian:bullseye

RUN apt-get update -y && apt-get install mariadb-server -y

COPY ./tools/server.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY ./tools/create_database.sh /

RUN chmod +x /create_database.sh

CMD ["/create_database.sh"]