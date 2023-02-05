FROM ghcr.io/epfl-si/common-web:1.6.0
LABEL maintainer "isas-fsd@groupes.epfl.ch"

USER 0
################################################################################
# System packages
################################################################################
RUN apt-get update && apt-get install -y \
        openssl \
        cpanminus \
        make \
        libdbi-perl \
        libnet-ssleay-perl \
        libwww-perl \
        libtext-unidecode-perl \
        gcc \
        unzip \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

COPY cpanfile cpanfile
RUN cpanm --installdeps --notest . || ( cat /root/.cpanm/work/*/build.log; exit 1 )

# Tequila config files
COPY ./conf/docker/dbs.conf /home/dinfo
COPY ./conf/docker/tequila.conf /home/dinfo
RUN touch /etc/tequila.conf
COPY ./conf/docker/25-payonline.epfl.ch.conf /etc/apache2/sites-available/
################################################################################
# Vhost
################################################################################
RUN mkdir -p /var/www/vhosts/payonline.epfl.ch/cgi-bin && \
    mkdir -p /var/www/vhosts/payonline.epfl.ch/conf && \
    mkdir -p /var/www/vhosts/payonline.epfl.ch/htdocs/js && \
    mkdir -p /var/www/vhosts/payonline.epfl.ch/htdocs/styles && \
    mkdir -p /var/www/vhosts/payonline.epfl.ch/htdocs/images && \
    mkdir -p /var/www/vhosts/payonline.epfl.ch/logs && \
    mkdir -p /var/www/vhosts/payonline.epfl.ch/private/tmpl && \
    mkdir -p /var/www/vhosts/payonline.epfl.ch/private/Tequila/Sessions

COPY ./conf/payonline.conf /var/www/vhosts/payonline.epfl.ch/conf/payonline.conf

WORKDIR /var/www/vhosts/payonline.epfl.ch

RUN mkdir -p /var/www/vhosts/payonline.epfl.ch/private/lib && \
    mkdir -p /var/www/vhosts/payonline.epfl.ch/private/lib/lib/perl5

################################################################################
# Apache
################################################################################
COPY ./conf/docker/25-payonline.epfl.ch.conf /etc/apache2/sites-available/25-payonline.epfl.ch.conf

RUN set -e -x; \
    a2enmod cgi ; \
    a2dissite 000-default.conf ; \
    a2dissite default-ssl.conf ; \
    a2ensite 25-payonline.epfl.ch.conf

################################################################################
# App
################################################################################
ADD ./perllib/ /opt/dinfo/lib/perl/
COPY ./cgi-bin/messages.txt /opt/dinfo/lib/perl/messages.txt
COPY ./cgi-bin/. /var/www/vhosts/payonline.epfl.ch/cgi-bin/
COPY ./htdocs/. /var/www/vhosts/payonline.epfl.ch/htdocs/
COPY ./private/tmpl/. /var/www/vhosts/payonline.epfl.ch/private/tmpl/

################################################################################
# Entrypoint
################################################################################
COPY ./conf/docker/docker-entrypoint.sh /home/dinfo/
RUN chmod a+x /home/dinfo/docker-entrypoint.sh

################################################################################
# Cron scripts
################################################################################
COPY ./scripts /opt/dinfo/scripts/
RUN chmod a+x /opt/dinfo/scripts/*

################################################################################
# Ownership so that these folders can be written when running in K8S
################################################################################
RUN chgrp -R 0 /opt/dinfo/etc && chmod -R g=u /opt/dinfo/etc
RUN chgrp -R 0 /etc/tequila.conf && chmod -R g=u /etc/tequila.conf
RUN chgrp -R 0 /etc/apache2/sites-available && chmod -R g=u /etc/apache2/sites-available
RUN chgrp -R 0 /var/www/vhosts/payonline.epfl.ch && chmod -R g=u /var/www/vhosts/payonline.epfl.ch
RUN chgrp -R 0 /home/dinfo && chmod -R g=u /home/dinfo

USER 1001

ENV TERM=xterm
ENV TZ=Europe/Zurich
ENV PERL5LIB=/opt/dinfo/lib/perl

# Use Apache2 graceful stop to terminate
STOPSIGNAL SIGWINCH
EXPOSE 8080
ENTRYPOINT ["/home/dinfo/docker-entrypoint.sh"]
