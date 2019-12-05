kubectl apply -f install/kubernetes/helm/helm-service-account.yaml
helm init --service-account tiller
helm install istio --name istio --namespace istio-system
helm install istio --namespace istio-system --set sidecarInjectorWebhook.enabled=true --generate-name
helm install sidecarInjectorWebhook --generate-name --namespace istio-system --set sidecarInjectorWebhook.enabled=true
helm path

kubectl get clusterrole runAsUser -o yaml --all-namespaces
kubectl get psp runAsUser -o yaml --all-namespaces

kubectl get PodSecurityPolicy --all-namespaces 

kubectl apply -f psp-all.yaml
