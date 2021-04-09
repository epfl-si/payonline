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
