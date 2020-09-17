FROM httpd:2.4

RUN apt-get update \
    && apt-get install -y cron \
        supervisor \
        procps \
        wget

# Install and configure confd.
RUN wget https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 \
	&& mv confd-0.16.0-linux-amd64 /usr/local/bin/confd \
	&& chmod +x /usr/local/bin/confd
COPY conf/confd /etc/confd

# httpd
RUN mkdir -p /var/log/httpd \
	&& mkdir -p /www/default \
	&& chown -R www-data:www-data /www/default
COPY conf/httpd/httpd.conf /usr/local/apache2/conf/httpd.conf
COPY src/index.html /www/default/

# stats
RUN mkdir -p /opt/bin
COPY scripts/stats.sh /opt/bin
RUN chmod +x /opt/bin/stats.sh

# Supervisor conf
COPY conf/supervisord/ /etc/supervisor/conf.d/

# entrypoint
COPY scripts/docker-entrypoint.sh /usr/bin/docker-entrypoint
RUN chmod +x /usr/bin/docker-entrypoint 

# Expose
EXPOSE 8080 8081

# Enter me
CMD ["docker-entrypoint"]