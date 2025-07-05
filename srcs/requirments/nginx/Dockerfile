FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

RUN apt install nginx -y openssl -y

# ENV domain_name="ciuschi.it"

RUN rm -r /etc/nginx/sites-available/

COPY tools/default /etc/nginx/sites-available/

RUN mkdir /etc/nginx/tls

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/tls/localhost.key \
	-out /etc/nginx/tls/self_signed.crt \
	-subj /C=US/ST=Denial/L=Springfield/O=Dis/CN=localhost

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]



