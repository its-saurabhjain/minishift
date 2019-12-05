﻿#minishift stop
#minishift delete -f
#minishift delete --clear-cache --force
#mkdir "C:\Users\Saurabh Jain\.minishift\cache\"
#Copy-Item "C:\Users\Saurabh Jain\.minishift\backup\*" -Recurse -Destination "C:\Users\Saurabh Jain\.minishift\cache\"
$env:HYPERV_VIRTUAL_SWITCH="Default Switch"
minishift config set hyperv-virtual-switch "Default Switch"
minishift config set static-ip true
minishift config set vm-driver hyperv
minishift config set memory 8GB
minishift config set cpus 4
minishift config set image-caching true
minishift config set openshift-version v3.11.0
minishift config set skip-startup-checks true
minishift addon enable admin-user

Start-Sleep -s 25 
minishift start  --show-libmachine-logs --v 1 --profile minishift
#minishift start --show-libmachine-logs --skip-registration --skip-startup-checks true --profile minishift
#minishift start --iso-url "file://C:/Users/Saurabh Jain/.minishift/cache/iso/centos/v1.15.0/minishift-centos7.iso" --show-libmachine-logs --skip-registration --skip-startup-checks true --profile minishift
Start-Sleep -m 10
minishift addons install --defaults
minishift addons apply admissions-webhook
minishift openshift config view --target kube
minishift addon apply anyuid 
minishift docker-env
minishift docker-env | Invoke-Expression
kubectl config set-context minishift
oc config set-context minishift
minishift addons apply admin-user
oc login -u system:admin
oc adm policy add-cluster-role-to-user cluster-admin admin
oc login -u admin -p admin