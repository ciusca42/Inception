FROM debian:bullseye

RUN apt-get update -y

RUN apt-get install mariadb-server -y

COPY /tools/50-server.cnf  /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/create_database.sh /

CMD [ "./create_stabase.sh" ]