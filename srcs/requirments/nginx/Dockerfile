FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

RUN apt install nginx -y openssl -y

RUN apt-get install curl -y
# ENV domain_name="ciuschi.it"

RUN rm -rf /etc/nginx/sites-available/* /etc/nginx/sites-enabled/*

COPY ./tools/default /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

RUN mkdir /etc/nginx/tls

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/tls/localhost.key \
	-out /etc/nginx/tls/self_signed.crt \
	-subj /C=US/ST=Denial/L=Springfield/O=Dis/CN=localhost

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]



