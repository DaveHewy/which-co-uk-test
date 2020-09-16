FROM httpd:2.4

RUN apt-get update \
    && apt-get install -y cron \
        supervisor \
        procps

COPY conf/httpd/httpd.conf /usr/local/apache2/conf/httpd.conf
COPY conf/httpd/vhosts.conf /usr/local/apache2/conf/extra/httpd-vhosts.conf
COPY src/index.html /usr/local/apache2/htdocs/

# stats generation bash
RUN mkdir -p /opt/bin
COPY scripts/stats.sh /opt/bin
RUN chmod +x /opt/bin/stats.sh

# Supervisor configs
COPY conf/supervisord/ /etc/supervisor/conf.d/

# Configure entrypoint
COPY scripts/docker-entrypoint.sh /usr/bin/docker-entrypoint
RUN chmod +x /usr/bin/docker-entrypoint 

# Enter me
CMD ["docker-entrypoint"]