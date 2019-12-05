oc project istio-system
cd "C:\Program Files\Kubernetes\istio-1.4.0"
kubectl apply -f samples/bookinfo/telemetry/log-entry.yaml
#invoke service generate traffic
for($i=0; $i -lt 10; $i++){
   
   Invoke-RestMethod -Uri "http://istio-ingressgateway-istio-system.172.17.158.7.nip.io/productpage"
   Start-Sleep -s 10
}
kubectl get pods

kubectl logs -n istio-system -l istio-mixer-type=telemetry -c mixer | Select-String "newlog" | Select-String -v '"destination":"telemetry"' | Select-String -v '"destination":"pilot"' | Select-String -v '"destination":"policy"' | Select-String -v '"destination":"unknown"'

oc new-project sleep
#kubectl apply -f samples/sleep/sleep.yaml
istioctl kube-inject -f samples/sleep/sleep.yaml | kubectl apply -f-
$SOURCE_POD=$(kubectl get pod -l app=sleep -o jsonpath={.items..metadata.name})
#$ kubectl apply -f samples/httpbin/httpbin.yaml
istioctl kube-inject -f samples/httpbin/httpbin.yaml | kubectl apply -f-

#enable envoy accessing log
istioctl manifest apply --set values.global.proxy.accessLogFile="/dev/stdout"
#test log
kubectl exec -it $(kubectl get pod -l app=sleep -o jsonpath='{.items[0].metadata.name}') -c sleep -- curl -v httpbin:8000/status/418
kubectl logs -l app=sleep -c istio-proxy
kubectl logs -l app=httpbin -c istio-proxy

$ kubectl delete -f samples/sleep/sleep.yaml
$ kubectl delete -f samples/httpbin/httpbin.yaml

#Edit the istio configuration map and set accessLogFile to "".
istioctl manifest apply --set values.global.proxy.accessLogFile=""