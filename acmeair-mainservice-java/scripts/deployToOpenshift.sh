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

#!/bin/bash

if [[ "${1}" == "--with-microclimate" ]]
then 
  MANIFESTS=manifests
else
  MANIFESTS=manifests-no-mc
fi

cd "$(dirname "$0")"
#delete all instances in manifest of this microservice on Openshift
cd ..
kubectl delete -f ${MANIFESTS}
if [[ `grep -c sys-ltic-docker-local.artifactory.swg-devops.com ${MANIFESTS}/deploy-acmeair-mainservice-java.yaml` == 0 ]]
then
  echo "Adding sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/"
  sed -i "s@acmeair-mainservice-java:latest@sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/acmeair-mainservice-java:latest@" ${MANIFESTS}/deploy-acmeair-mainservice-java.yaml
fi
#Now add all new instances of all mainservice relevant deployments
kubectl apply -f ${MANIFESTS}
echo "Removing sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/"
sed -i "s@sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/acmeair-mainservice-java:latest@acmeair-mainservice-java:latest@" ${MANIFESTS}/deploy-acmeair-mainservice-java.yaml

#repeat pattern for all other services
cd ../acmeair-authservice-java
kubectl delete -f ${MANIFESTS}
if [[ `grep -c sys-ltic-docker-local.artifactory.swg-devops.com ${MANIFESTS}/deploy-acmeair-authservice-java.yaml` == 0 ]]
then
  echo "Adding sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/"
  sed -i "s@acmeair-authservice-java:latest@sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/acmeair-authservice-java:latest@" ${MANIFESTS}/deploy-acmeair-authservice-java.yaml
fi
kubectl apply -f ${MANIFESTS}
echo "Removing sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/"
sed -i "s@sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/acmeair-authservice-java:latest@acmeair-authservice-java:latest@" ${MANIFESTS}/deploy-acmeair-authservice-java.yaml


cd ../acmeair-bookingservice-java
kubectl delete -f ${MANIFESTS}
if [[ `grep -c sys-ltic-docker-local.artifactory.swg-devops.com ${MANIFESTS}/deploy-acmeair-bookingservice-java.yaml` == 0 ]]
then
  echo "Adding sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/"
  sed -i "s@acmeair-bookingservice-java:latest@sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/acmeair-bookingservice-java:latest@" ${MANIFESTS}/deploy-acmeair-bookingservice-java.yaml
fi
kubectl apply -f ${MANIFESTS}
echo "Removing sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/"
sed -i "s@sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/acmeair-bookingservice-java:latest@acmeair-bookingservice-java:latest@" ${MANIFESTS}/deploy-acmeair-bookingservice-java.yaml


cd ../acmeair-customerservice-java
kubectl delete -f ${MANIFESTS}
if [[ `grep -c sys-ltic-docker-local.artifactory.swg-devops.com ${MANIFESTS}/deploy-acmeair-customerservice-java.yaml` == 0 ]]
then
  echo "Adding sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/"
  sed -i "s@acmeair-customerservice-java:latest@sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/acmeair-customerservice-java:latest@" ${MANIFESTS}/deploy-acmeair-customerservice-java.yaml
fi
kubectl apply -f ${MANIFESTS}
echo "Removing sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/"
sed -i "s@sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/acmeair-customerservice-java:latest@acmeair-customerservice-java:latest@" ${MANIFESTS}/deploy-acmeair-customerservice-java.yaml


cd ../acmeair-flightservice-java
kubectl delete -f ${MANIFESTS}
if [[ `grep -c sys-ltic-docker-local.artifactory.swg-devops.com ${MANIFESTS}/deploy-acmeair-flightservice-java.yaml` == 0 ]]
then
  echo "Adding sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/"
  sed -i "s@acmeair-flightservice-java:latest@sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/acmeair-flightservice-java:latest@" ${MANIFESTS}/deploy-acmeair-flightservice-java.yaml
fi
kubectl apply -f ${MANIFESTS}
echo "Removing sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/"
sed -i "s@sys-ltic-docker-local.artifactory.swg-devops.com/acmeair/acmeair-flightservice-java:latest@acmeair-flightservice-java:latest@" ${MANIFESTS}/deploy-acmeair-flightservice-java.yaml
