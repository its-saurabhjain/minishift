minishift docker-env
minishift docker-env | Invoke-Expression
kubectl config set-context minishift
oc config set-context minishift
minishift addons apply admin-user
oc login -u system:admin
oc adm policy add-cluster-role-to-user cluster-admin admin
oc login -u admin -p admin
##########################################################
oc new-project bookinfo
Start-Sleep -s 10
oc project bookinfo
cd "C:\Program Files\Kubernetes\istio-1.4.0"

oc adm policy add-scc-to-group privileged system:serviceaccounts -n bookinfo
oc adm policy add-scc-to-group anyuid system:serviceaccounts -n bookinfo

kubectl label namespace bookinfo istio-injection=true --overwrite
kubectl label namespace istio-system istio-injection=true --overwrite
#kubectl get namespace -L istio-injection

#oc adm policy add-scc-to-user anyuid -z bookinfo
#oc adm policy add-scc-to-user privileged -z bookinfo
#oc adm policy add-scc-to-user privileged -z default -n bookinfo
#oc adm policy add-cluster-role-to-user cluster-admin -z default

#Auto injection
#kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml

#explicit inject side-care
#kubectl -n istio-system get configmap istio-sidecar-injector -o=jsonpath='{.data.config}' > inject-config.yaml
#kubectl -n istio-system get configmap istio-sidecar-injector -o=jsonpath='{.data.values}' > inject-values.yaml
#kubectl -n istio-system get configmap istio -o=jsonpath='{.data.mesh}' > mesh-config.yaml
#istioctl kube-inject --injectConfigFile inject-config.yaml --meshConfigFile mesh-config.yaml --valuesFile inject-values.yaml --filename samples\bookinfo\platform\kube\bookinfo.yaml > bookinfo_inject.yaml
kubectl apply -f samples/bookinfo/platform/kube/bookinfo_inject.yaml
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
kubectl get gateway
#kubectl get svc istio-ingressgateway -n istio-system
#$INGRESS_HOST=$(kubectl get po -l istio=ingressgateway -n istio-system -o jsonpath='{.items[0].status.hostIP}')
#$INGRESS_PORT = 8080
$INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
#$INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")]}.port')
#$SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')
#$GATEWAY_URL="$INGRESS_HOST" +":" + "$INGRESS_PORT"
#Invoke-RestMethod uri "http://${GATEWAY_URL}/productpage"

#Others commands
#kubectl describe pods productpage-v1-b79d7cb66-kbgbq
#kubectl -n istio-system get configmap istio-sidecar-injector -o=jsonpath='{.data.config}'
#kubectl get svc --namespace=istio-system | Select-String sidecar-injector
#kubectl describe replicaset.apps/productpage-v1-6b9bcdff4f
#kubectl get deployment productpage-v1  -o yaml | Select-String "sidecar.istio.io/inject:"