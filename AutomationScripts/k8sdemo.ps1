minishift docker-env
minishift docker-env | Invoke-Expression
kubectl config set-context minishift
oc config set-context minishift
minishift addons apply admin-user
oc login -u system:admin
oc adm policy add-cluster-role-to-user cluster-admin admin
oc login -u admin -p admin

##########################################################
oc new-project k8sdemo
Start-Sleep -s 10
oc project k8sdemo
cd "C:\Infosys-Citizen\POC\codestatebkend"
docker build -t codestatebkend:v1 ./
Start-Sleep -s 20
cd "C:\Infosys-Citizen\POC\codestate"
docker build -t codestate:v1 ./
Start-Sleep -s 20
kubectl run dataservice --image=codestatebkend:v1 --port 8080 --labels="app=codestatebkend,tier=backend"
kubectl run userapi --image=codestate:v1 --port 8080 --labels="app=codestate,tier=frontend"
Start-Sleep -s 20
#create configmap (for backend data service) update configmap with the minishift ip
kubectl apply -f dataservice-configmap.yaml
#apply config map to deployment
kubectl apply -f codestate-deployment.yaml
#create service and expose it
kubectl expose deployment userapi --type=LoadBalancer --port 80 --target-port 8080
kubectl expose deployment dataservice --type=ClusterIP --port 80 --target-port 8080 --selector="app=codestatebkend,tier=backend"
oc expose svc userapi
oc expose svc dataservice

#oc patch netnamespace k8sdemo -p '{"egressIPs":["151.101.40.133"]}'
#oc patch hostsubnet node2.ocp.io -p '{"egressIPs": ["192.168.1.102"]}'
#oc api-resources --namespaced=false
#oc get all
