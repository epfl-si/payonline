# Payonline

payonline.epfl.ch met à disposition un canal d'encaissement électronique pour les manifestations, conférences, vente de services, liés à l'EPFL.
L'accès à ce service est soumis au droit *payonline* du système d'accréditation.

## Déploiement

### Déploiement on VM

Déploiement to test VMs
```
./deploy_test.sh
```

Déploiement to prod VMs
```
./deploy_prod.sh
```

### Déploiement sur OpenShift

Déploiement vers le namespace de test
```
./deploy_os.sh  -t develop -n payonline-test
```

Déploiement vers le namespace de prod
```
./deploy_os.sh  -t v1.0.0 -n payonline-prod
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
