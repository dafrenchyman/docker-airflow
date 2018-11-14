#!/bin/bash
##############################################################
# Function to remove airflow from kubernetes cluster
##############################################################
uninstall_airflow() {

  # Remove port forwarding
  PORT_FORWARD_PROCESS=`ps -ef | grep "kubectl port-forward airflow" | grep -v "grep" | awk '{ print $2 }'`
  kill ${PORT_FORWARD_PROCESS}

  # Uninstall airflow via helm
  helm delete --purge airflow
  echo "Waiting 60 seconds for services to shut down"
  sleep 60

  # Remove pods that refuse to go away
  export AIRFLOW_TO_PURGE=`kubectl get pods | grep airflow | cut -f1 -d' '`
  for i in "${AIRFLOW_TO_PURGE[@]}"
  do
    echo "Purging: ${i}"
    kubectl delete pods $i --grace-period=0 --force
  done
  
  # Delete airflow service account
  kubectl delete clusterrolebinding airflow 
  kubectl delete serviceaccount airflow --namespace=${NAMESPACE}
  
  # Delete secrets
  kubectl delete secret invoice-processing-env
  kubectl delete secret invoice-processing-google-app-cred
  kubectl delete secret gcr-json-key
}


uninstall_airflow