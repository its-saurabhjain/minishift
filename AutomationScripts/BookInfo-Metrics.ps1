cd "C:\Program Files\Kubernetes\istio-1.4.0"
oc project bookinfo
#apply telementry
kubectl apply -f samples/bookinfo/telemetry/metrics.yaml
#invoke service generate traffic
for($i=0; $i -lt 10; $i++){
   
   Invoke-RestMethod -Uri "http://istio-ingressgateway-istio-system.172.17.158.7.nip.io/productpage"
   Start-Sleep -s 10
}

kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=prometheus -o jsonpath='{.items[0].metadata.name}') 9090:9090
#http://localhost:9090