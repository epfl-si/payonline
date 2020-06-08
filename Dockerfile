FROM debian:buster
LABEL maintainer "olivier.delobre@epfl.ch"

################################################################################
# System packages
################################################################################
RUN apt-get update && apt-get install -y \
        apache2 \
        libaio1 \
        libapache2-mod-perl2 \
        default-libmysqlclient-dev \
        locales \
        default-mysql-client\
        sudo \
        unzip \
        gettext-base \
        openssl \
        cpanminus \
        make \
        libdbi-perl \
        gcc \
        vim \
        curl \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

################################################################################
# Localization
################################################################################
RUN echo "Europe/Zurich" > /etc/timezone && \
    dpkg-reconfigure --frontend=noninteractive tzdata && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# de_CH.UTF-8 UTF-8/de_CH.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8 && \
    update-locale LC_CTYPE=en_US.UTF-8 && \
    update-locale LC_NUMERIC=de_CH.UTF-8 && \
    update-locale LC_TIME=de_CH.UTF-8 && \
    update-locale LC_COLLATE=en_US.UTF-8 && \
    update-locale LC_MONETARY=de_CH.UTF-8 && \
    update-locale LC_MESSAGES=en_US.UTF-8 && \
    update-locale LC_PAPER=de_CH.UTF-8 && \
    update-locale LC_NAME=de_CH.UTF-8 && \
    update-locale LC_ADDRESS=de_CH.UTF-8 && \
    update-locale LC_TELEPHONE=de_CH.UTF-8 && \
    update-locale LC_MEASUREMENT=de_CH.UTF-8 && \
    update-locale LC_IDENTIFICATION=de_CH.UTF-8

# set it for bash too
ENV LANG=en_US.UTF-8 \
    LC_CTYPE=en_US.UTF-8 \
    LC_NUMERIC=de_CH.UTF-8 \
    LC_TIME=de_CH.UTF-8 \
    LC_COLLATE=en_US.UTF-8 \
    LC_MONETARY=de_CH.UTF-8 \
    LC_MESSAGES=en_US.UTF-8 \
    LC_PAPER=de_CH.UTF-8 \
    LC_NAME=de_CH.UTF-8 \
    LC_ADDRESS=de_CH.UTF-8 \
    LC_TELEPHONE=de_CH.UTF-8 \
    LC_MEASUREMENT=de_CH.UTF-8 \
    LC_IDENTIFICATION=de_CH.UTF-8

################################################################################
# Users & groups
################################################################################
RUN echo "umask 0002" >> /etc/bash.bashrc && \
    echo "umask 0002" >> /etc/profile

RUN groupadd apache && \
    useradd -r -g apache apache

RUN useradd -m -s /bin/bash -G apache,adm dinfo && \
    echo "apache ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    echo "dinfo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    echo "dinfo:dinfo" | sudo chpasswd

################################################################################
# Perl deps (DBD::Oracle, Tequila, ...)
################################################################################
RUN mkdir -p /opt/oracle && \
    mkdir -p /opt/dinfo/lib/perl/Accred && \
    mkdir -p /opt/dinfo/lib/perl/Cadi && \
    mkdir -p /opt/dinfo/lib/perl/Tequila && \
    mkdir -p /opt/dinfo/etc && \
    chown -R dinfo:dinfo /opt/dinfo

# FIXME: from cpanfile ?
RUN cpanm --notest \
          Apache::DBI \
          JSON \
          IO::Socket::SSL \
          IO::Socket::INET \
          Crypt::Rijndael \
          Crypt::GCM \
          Net::LDAP \
          Crypt::RC4 \
          Plack::Handler::Apache2 \
          Net::IP \
          DBD::mysql \
          HTML::Template \
          Mail::Sendmail \
          Net::CIDR \
          JSON::SL \
          local::lib

# Tequila config files
COPY ./conf/docker/dbs.conf /home/dinfo
COPY ./conf/docker/tequila.conf /home/dinfo
RUN touch /etc/tequila.conf && chown dinfo:dinfo /etc/tequila.conf
COPY ./conf/docker/25-payonline.epfl.ch.conf /home/dinfo

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
    mkdir -p /var/www/vhosts/payonline.epfl.ch/private/Tequila/Sessions && \
    chown dinfo:apache /var/www/vhosts/payonline.epfl.ch/private/Tequila/Sessions

COPY ./conf/payonline.conf /var/www/vhosts/payonline.epfl.ch/conf/payonline.conf

WORKDIR /var/www/vhosts/payonline.epfl.ch

RUN mkdir -p /var/www/vhosts/payonline.epfl.ch/private/lib && \
    mkdir -p /var/www/vhosts/payonline.epfl.ch/private/lib/lib/perl5 && \
    chown -R dinfo:apache /var/www/vhosts/payonline.epfl.ch/private/lib && \
    chmod g+w /var/www/vhosts/payonline.epfl.ch/private/lib/lib/perl5

COPY ./conf/params /var/www/vhosts/payonline.epfl.ch/private/params

RUN echo '0123456789abcdef0123456789abcdef' > /var/www/vhosts/payonline.epfl.ch/private/csrfkey
RUN echo '0123456789ABCDEFGHIJKLMNOPQRSTUV' > /var/www/vhosts/payonline.epfl.ch/private/pwdkey

################################################################################
# Apache
################################################################################
RUN mkdir -p /etc/apache2/conf.d && \
    mkdir /etc/apache2/ssl

COPY ./conf/docker/apache2.conf /etc/apache2/apache2.conf
COPY ./conf/docker/ports.conf /etc/apache2/ports.conf
COPY ./conf/docker/25-payonline.epfl.ch.conf /etc/apache2/sites-available/25-payonline.epfl.ch.conf
RUN chown dinfo:dinfo /etc/apache2/sites-available/25-payonline.epfl.ch.conf
COPY ./conf/docker/dinfo-perl.conf ./conf/docker/perl.conf \
     /etc/apache2/conf.d/

RUN echo "umask 0002" >> /etc/apache2/envvars && \
    openssl genrsa -out /etc/apache2/ssl/key.pem 2048 && \
    openssl req -new -sha256 -key /etc/apache2/ssl/key.pem -nodes -subj "/CN=dev-payonline" -out /etc/apache2/ssl/apache.pem && \
    openssl x509 -req -in /etc/apache2/ssl/apache.pem -signkey /etc/apache2/ssl/key.pem -out /etc/apache2/ssl/apache.pem && \

    a2enmod ssl  && \
    a2enmod rewrite && \
    a2enmod headers && \
    a2enmod perl && \
    a2enmod env && \

    a2dissite 000-default.conf && \
    a2dissite default-ssl.conf && \
    a2ensite 25-payonline.epfl.ch.conf

################################################################################
# Libraries
################################################################################
COPY ./cadi-libs/Cadi/. /opt/dinfo/lib/perl/Cadi/
COPY ./accred-libs/Accred/. /opt/dinfo/lib/perl/Accred/
COPY ./tequila-epfl/lib/Tequila/. /opt/dinfo/lib/perl/Tequila/
COPY ./tequila-perl-client/Tequila/Client.pm /opt/dinfo/lib/perl/Tequila/Client.pm
COPY ./cgi-bin/payonline_tools.pm /opt/dinfo/lib/perl/payonline_tools.pm

################################################################################
# App
################################################################################
COPY ./cgi-bin/. /var/www/vhosts/payonline.epfl.ch/cgi-bin/
COPY ./htdocs/. /var/www/vhosts/payonline.epfl.ch/htdocs/
COPY ./private/tmpl/. /var/www/vhosts/payonline.epfl.ch/private/tmpl/

RUN chown -R dinfo:dinfo /var/www/vhosts/payonline.epfl.ch && \
    chown -R apache:dinfo /var/www/vhosts/payonline.epfl.ch/htdocs && \
    chown -R apache:apache /var/www/vhosts/payonline.epfl.ch/logs && \
    chown -R apache:apache /var/www/vhosts/payonline.epfl.ch/private/Tequila/Sessions && \
    chown apache:dinfo /var/www/vhosts/payonline.epfl.ch/private && \
    chmod g+w /var/www/vhosts/payonline.epfl.ch/private

COPY ./conf/docker/docker-entrypoint.sh /home/dinfo/
RUN chmod a+x /home/dinfo/docker-entrypoint.sh

################################################################################
# Ownership so that these folders can be written when running in K8S
################################################################################
RUN chgrp -R 0 /opt/dinfo/etc && chmod -R g=u /opt/dinfo/etc
RUN chgrp -R 0 /etc/tequila.conf && chmod -R g=u /etc/tequila.conf
RUN chgrp -R 0 /etc/apache2/sites-available && chmod -R g=u /etc/apache2/sites-available
RUN chgrp -R 0 /var/www/vhosts/groups.epfl.ch && chmod -R g=u /var/www/vhosts/groups.epfl.ch
RUN chgrp -R 0 /home/dinfo && chmod -R g=u /home/dinfo

ENV TERM=xterm
ENV TZ=Europe/Zurich
ENV PERL5LIB=/opt/dinfo/lib/perl

USER 1001
ENTRYPOINT ["/home/dinfo/docker-entrypoint.sh"]