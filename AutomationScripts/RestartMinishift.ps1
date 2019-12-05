minishift stop
minishift start --profile minishift
minishift docker-env
minishift docker-env | Invoke-Expression
kubectl config set-context minishift
oc config set-context minishift
minishift addons apply admin-user
oc login -u system:admin
oc adm policy add-cluster-role-to-user cluster-admin admin
oc login -u admin -p admin