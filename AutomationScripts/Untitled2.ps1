kubectl -n istio-system get configmap istio-sidecar-injector -o jsonpath='{.data.config}' | Select-String policy:
kubectl get deployment
kubectl get deployment productpage-v1 -o yaml | select-string "sidecar.istio.io/inject:"

kubectl get mutatingwebhookconfiguration istio-sidecar-injector -o yaml -o jsonpath='{.webhooks[0].clientConfig.caBundle}'
kubectl -n istio-system get secret istio.istio-sidecar-injector-service-account -o jsonpath='{.data.root-cert\.pem}'
kubectl -n istio-system get pod -listio=sidecar-injector
kubectl -n istio-system get endpoints istio-sidecar-injector

kubectl -n istio-system get serviceaccount istio-sidecar-injector-service-account
kubectl get clusterrole istio-sidecar-injector-istio-system
kubectl describe clusterrolebinding istio-sidecar-injector-admin-role-binding-istio-system

helm template -n istio-system --set kubernetesDistribution=OpenShift ./chart/istio-pod-network-controller | oc apply -f -