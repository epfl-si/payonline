#!/usr/bin/env bash

vhost='/var/www/vhosts/payonline.epfl.ch'

user='dinfo'
hosts='test-dinfo1.epfl.ch test-dinfo2.epfl.ch'

for h in ${hosts}; do
    ssh="ssh ${user}@${h}"
    dest="${user}@${h}"

    scp -r cgi-bin/*  ${dest}:${vhost}/cgi-bin/
    scp -r htdocs/*   ${dest}:${vhost}/htdocs/

    ${ssh} 'sudo apachectl graceful'
done