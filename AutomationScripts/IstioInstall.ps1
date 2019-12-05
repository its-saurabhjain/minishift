kubectl config set-context minishift
oc config set-context minishift
minishift addons apply admin-user
oc login -u system:admin
oc adm policy add-cluster-role-to-user cluster-admin admin
oc login -u admin -p admin
#create project
oc new-project istio-system
Start-Sleep 10
oc project istio-system
kubectl label namespace istio-system istio-injection=enabled --overwrite
#apply istio-security
oc adm policy add-scc-to-group anyuid system:serviceaccounts -n istio-system
oc adm policy add-scc-to-user anyuid -z default
oc adm policy add-scc-to-user privileged -z default
oc adm policy add-cluster-role-to-user cluster-admin -z default
oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account
oc adm policy add-scc-to-user privileged -z istio-ingress-service-account
oc adm policy add-scc-to-user anyuid -z istio-egress-service-account
oc adm policy add-scc-to-user privileged -z istio-egress-service-account
oc adm policy add-scc-to-user anyuid -z istio-pilot-service-account
oc adm policy add-scc-to-user privileged -z istio-pilot-service-account
oc adm policy add-scc-to-user anyuid -z istio-grafana-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-prometheus-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z prometheus -n istio-system
oc adm policy add-scc-to-user privileged -z prometheus
oc adm policy add-scc-to-user anyuid -z grafana -n istio-system
oc adm policy add-scc-to-user privileged -z grafana
oc adm policy add-scc-to-user anyuid -z default
oc adm policy add-scc-to-user privileged -z default
oc adm policy add-cluster-role-to-user cluster-admin -z default
minishift addon apply anyuid
cd "C:\Program Files\Kubernetes\istio-1.4.0"
#apply crd
oc apply -f install/kubernetes/istio-crd.yaml
Start-Sleep -s 10
oc apply -f install/kubernetes/istio-demo.yaml
Start-Sleep -s 10
oc expose svc istio-ingressgateway --port=80
oc expose svc grafana
oc expose svc prometheus
oc expose svc tracing
oc expose service kiali --path=/kiali
oc adm policy add-cluster-role-to-user admin system:serviceaccount:istio-system:kiali-service-account -z default