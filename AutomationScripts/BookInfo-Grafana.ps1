#The Grafana add-on is a preconfigured instance of Grafana. 
#The base image (grafana/grafana:5.2.3) has been modified to start with both a Prometheus data source and the Istio Dashboard installed. 
#The base install files for Istio, and Mixer in particular, ship with a default configuration of global (used for every service) metrics. 
#The Istio Dashboard is built to be used in conjunction with the default Istio metrics configuration and a Prometheus backend.

cd "C:\Program Files\Kubernetes\istio-1.4.0"
oc project bookinfo
kubectl -n istio-system get svc prometheus
kubectl -n istio-system get svc grafana

kubectl -n istio-system port-forward $(kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}') 3000:3000
#istio dash board via grafana -- Istio dashboard, service dashboard, workload dashboard
# http://localhost:3000/dashboard/db/istio-mesh-dashboard


#invoke service generate traffic
for($i=0; $i -lt 100; $i++){
   
   Invoke-RestMethod -Uri "http://istio-ingressgateway-istio-system.172.17.158.7.nip.io/productpage"
   Start-Sleep -s 10
}
#Remove any kubectl port-forward processes that may be running:

