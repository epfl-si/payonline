# Payonline

payonline.epfl.ch met à disposition un canal d'encaissement électronique pour les manifestations, conférences, vente de services, liés à l'EPFL.
L'accès à ce service est soumis au droit *payonline* du système d'accréditation.

## Déploiement

### Déploiement sur OpenShift

Le build se fait dans OpenShift. Pour le lancer :

```
./ops/paysible -t payonline.k8s.build
```

Une fois les tests concluants sur https://payonline-preprod.epfl.ch/ :

```
./ops/paysible --prod -t payonline.k8s,payonline.k8s.promote
```


## Troubleshooting

### Lancement en local

```
docker run --rm -it -v $PWD/vhosts:/var/www/vhosts \
    -v $PWD/conf/docker/dinfo-perl.conf:/etc/apache2/conf.d/dinfo-perl.conf \
    -v $PWD/conf/docker/25-payonline.epfl.ch.conf:/etc/apache2/sites-available/25-payonline.epfl.ch.conf \
    -v $PWD/log:/var/log -v $PWD/conf/docker:/home/dinfo \
    -v $PWD/cgi-bin:/var/www/vhosts/payonline.epfl.ch/cgi-bin \
    -p 8080:8080 os-docker-registry.epfl.ch/payonline-test/payonline:develop
```
