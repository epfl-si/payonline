#!/usr/bin/env bash

scp dinfo@dinfo1:/var/www/vhosts/payonline.epfl.ch/cgi-bin/\* cgi-bin/
scp -r dinfo@dinfo1:/var/www/vhosts/payonline.epfl.ch/htdocs/extra htdocs/
scp  dinfo@dinfo1:/var/www/vhosts/payonline.epfl.ch/private/tmpl/\* private/tmpl/