#!/bin/bash
# num of persistent volumn will be created in local when running make on a local context "make deploy-local, make deploy-ci-local, make deploy-gci-local".
PV_COUNT=42
scriptPath=`dirname $0`
# Create storage class
#
kubectl apply -f $scriptPath/sc-local-storage.yaml
kubectl patch storageclass local-storage -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
# Create static PVs using local storage
#
for i in $(seq 1 $PV_COUNT); do
  export PV_NUMBER=$i
  export PV_HOSTNAME=`kubectl get node --no-headers -o jsonpath={.items[0].metadata.name}`
  # Create half of the PVs for the logs claims, and half for the data claims
  #  
  if [[ $i -lt $((($PV_COUNT / 2) + 1)) ]]
  then
    export PV_SIZE=10Gi # Claimed by the logs
  else
    export PV_SIZE=15Gi # Claimed by the data
  fi
  mkdir -p /var/tmp/aris/pv/$PV_NUMBER
  envsubst < $scriptPath/pv-local-storage.yaml.tmpl > $scriptPath/pv-local-storage-$i.yaml
  kubectl apply -f $scriptPath/pv-local-storage-$i.yaml &
done
wait
for i in $(seq 1 $PV_COUNT); do
  rm $scriptPath/pv-local-storage-$i.yaml
done
