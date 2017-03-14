# Base image
FROM debian:jessie

# Made with love
MAINTAINER mark <norrkin@icloud.com>

# Get dependencies & create user
RUN dpkg --add-architecture i386 && \
	apt-get update && apt-get install -y libc6-i386 supervisor && \
	adduser --system --no-create-home --disabled-login --disabled-password --group ventrilo && \
	mkdir /srv/ventrilo

# Copy installer and untar
COPY ventrilo_srv-3.0.3-Linux-i386.tar.gz /srv/ventrilo
RUN cd /srv/ventrilo && \
	gunzip ventrilo_srv-3.0.3-Linux-i386.tar.gz && \
	tar xf ventrilo_srv-3.0.3-Linux-i386.tar

# Copy ventrilo config
COPY ventrilo_srv.ini /srv/ventrilo/ventsrv/

# Copy start script & set permissions
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh && \
	chown -R ventrilo:ventrilo /srv/ventrilo/ventsrv
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Open ports
EXPOSE 3784 3784/udp

# Execute start script
CMD ["/usr/bin/entrypoint.sh"]