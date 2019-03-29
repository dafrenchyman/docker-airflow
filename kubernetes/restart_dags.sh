#!/bin/bash
PODS_TO_RESTART=`kubectl get pods | grep -e airflow | cut -f1 -d " "`

for i in "${PODS_TO_RESTART[@]}"
do
	echo "Purging: ${i}"
    kubectl delete pods $i
done
