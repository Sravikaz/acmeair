#!/bin/bash
# Copyright (c) 2018 IBM Corp.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

MANIFESTS=manifests-openshift
if [ $# -eq 0 ]
  then
    echo "Using route name openshiftacmeair.com"
    ROUTENAME=$1
else
    echo "Using route name $1 "
    ROUTENAME=$1
fi
cd "$(dirname "$0")"
cd ..
kubectl delete -f ${MANIFESTS}
sed -i 's/openshiftacmeair.com/$1/g' acmeair-mainservice-route.yaml
kubectl apply -f ${MANIFESTS} --validate=false
cd ../acmeair-authservice-java
kubectl delete -f ${MANIFESTS}
sed -i 's/openshiftacmeair.com/$1/g' acmeair-mainservice-route.yaml
kubectl apply -f ${MANIFESTS} --validate=false
cd ../acmeair-bookingservice-java
kubectl delete -f ${MANIFESTS}
sed -i 's/openshiftacmeair.com/$1/g' acmeair-mainservice-route.yaml
kubectl apply -f ${MANIFESTS} --validate=false
cd ../acmeair-customerservice-java
kubectl delete -f ${MANIFESTS}
sed -i 's/openshiftacmeair.com/$1/g' acmeair-mainservice-route.yaml
kubectl apply -f ${MANIFESTS} --validate=false
cd ../acmeair-flightservice-java
kubectl delete -f ${MANIFESTS}
sed -i 's/openshiftacmeair.com/$1/g' acmeair-mainservice-route.yaml
kubectl apply -f ${MANIFESTS} --validate=false
