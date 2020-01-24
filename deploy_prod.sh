#!/usr/bin/env bash

vhost='/var/www/vhosts/payonline.epfl.ch'

user='dinfo'
hosts='dinfo1.epfl.ch dinfo2.epfl.ch'

for h in ${hosts}; do
    ssh="ssh ${user}@${h}"
    dest="${user}@${h}"

    scp -r cgi-bin/*  ${dest}:${vhost}/cgi-bin/
    scp -r htdocs/*   ${dest}:${vhost}/htdocs/

    ${ssh} 'sudo apachectl graceful'
done