FROM ubuntu:22.04

USER root

ENV VKEY=vshell
ENV ENCRYPT_SALT=vshell
ENV TITLE=vshell
ENV USERNAME=admin
ENV PASSWORD=qwe123qwe

WORKDIR /app

COPY ./vshell/ /app/

RUN apt-get update && apt-get install iptables net-tools -y
RUN chmod +x /app/start.sh /app/vshell

EXPOSE 8082 8084

CMD /app/start.sh
