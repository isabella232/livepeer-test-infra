# livepeer-test-infra

### record tester

helm upgrade --install record-tester ./charts/record-tester -f values/record-tester.yaml
helm uninstall record-tester

### ingress controller
kubectl apply -f values/ingress-controller-config.yml
helm upgrade --install ingress-controller ./charts/ingress-controller -f values/ingress-controller.yml 


### external-dns

helm upgrade --install external-dns ./charts/external-dns -f values/external-dns.yaml
helm uninstall external-dns

### http echo

helm upgrade --install http-echo-1 ./charts/http-echo
helm uninstall http-echo-1

### cdn-log-puller


#### create secret
kubectl apply -f values/cdn-puller-config.yaml

#### staging
helm install --dry-run --debug cdn-puller-st ./charts/cdn-puller -f values/cdn-puller-staging.yaml
helm install  --debug cdn-puller-st ./charts/cdn-puller -f values/cdn-puller-staging.yaml
helm uninstall  --debug cdn-puller-st
#### prod
helm upgrade --install   cdn-puller-prod ./charts/cdn-puller -f values/cdn-puller-prod.yaml
helm uninstall  --debug cdn-puller-prod


#### metabase
helm upgrade --install metabase ./charts/metabase -f values/metabase.yaml
helm install --dry-run --debug metabase ./charts/metabase -f values/metabase.yaml
helm uninstall metabase

### simple http server

servers dir `/usr/share/nginx/html` from inside container
available at `simple.test.livepeer.fish`


helm upgrade --install simple-http-server ./charts/simple-http-server
helm uninstall simple-http-server
