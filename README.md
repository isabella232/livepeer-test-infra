# livepeer-test-infra

### external-dns

helm upgrade --install external-dns ./charts/external-dns -f values/external-dns.yaml
helm uninstall external-dns

### http echo

helm upgrade --install http-echo-1 ./charts/http-echo
helm uninstall http-echo-1
