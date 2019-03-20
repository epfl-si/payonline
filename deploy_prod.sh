#!/usr/bin/env bash

vhost='/var/www/vhosts/payonline.epfl.ch'

user='dinfo'
hosts='dinfo1.epfl.ch dinfo2.epfl.ch'
#hosts='dinfo1.epfl.ch'
#hosts='dinfo2.epfl.ch'

for h in ${hosts}; do
    ssh="ssh ${user}@${h}"
    scp -r cgi-bin/* ${user}@${h}:${vhost}/cgi-bin/
    scp -r private/perl-mods/* ${user}@${h}:${vhost}/private/perl-mods/
    scp -r private/tmpl/* ${user}@${h}:${vhost}/private/tmpl/
    scp htdocs/payonline.js  ${user}@${h}:${vhost}/htdocs/
    scp htdocs/payonline.css ${user}@${h}:${vhost}/htdocs/
done
