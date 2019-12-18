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

if [[ ${2} == "" ]]
then
  echo "Usage: buildAndDeployToOpenshift.sh <IMAGE_PREFIX> <ROUTE_PATH>"
  exit
fi

IMAGE_PREFIX=${1}
ROUTE_HOST=${2}



echo "Image Prefix=${IMAGE_PREFIX}"
echo "Route Host=${ROUTE_HOST}"

cd "$(dirname "$0")"
cd ..
kubectl delete -f ${MANIFESTS}

if [[ `grep -c ${IMAGE_PREFIX} ${MANIFESTS}/deploy-acmeair-mainservice-java.yaml` == 0 ]]
then
  echo "Adding ${IMAGE_PREFIX}/"
  sed -i.bak "s@acmeair-mainservice-java-s390x:latest@${IMAGE_PREFIX}/acmeair-mainservice-java-s390x:latest@" ${MANIFESTS}/deploy-acmeair-mainservice-java.yaml
fi

if [[ `grep -c ${ROUTE_HOST} ${MANIFESTS}/acmeair-mainservice-route.yaml` == 0 ]]
then
  echo "Patching Route Host: ${ROUTE_HOST}"
  sed -i.bak "s@_HOST_@${ROUTE_HOST}@" ${MANIFESTS}/acmeair-mainservice-route.yaml
fi

kubectl apply -f ${MANIFESTS}

echo "Removing ${IMAGE_PREFIX}"
sed -i.bak "s@${IMAGE_PREFIX}/acmeair-mainservice-java-s390x:latest@acmeair-mainservice-java-s390x:latest@" ${MANIFESTS}/deploy-acmeair-mainservice-java.yaml

echo "Removing ${ROUTE_HOST}"
sed -i.bak "s@${ROUTE_HOST}@_HOST_@" ${MANIFESTS}/acmeair-mainservice-route.yaml

cd ../acmeair-authservice-java
kubectl delete -f ${MANIFESTS}

if [[ `grep -c ${IMAGE_PREFIX} ${MANIFESTS}/deploy-acmeair-authservice-java.yaml` == 0 ]]
then
  echo "Adding ${IMAGE_PREFIX}/"
  sed -i.bak "s@acmeair-authservice-java-s390x:latest@${IMAGE_PREFIX}/acmeair-authservice-java-s390x:latest@" ${MANIFESTS}/deploy-acmeair-authservice-java.yaml
fi

if [[ `grep -c ${ROUTE_HOST} ${MANIFESTS}/acmeair-authservice-route.yaml` == 0 ]]
then
  echo "Patching Route Host: ${ROUTE_HOST}"
  sed -i.bak "s@_HOST_@${ROUTE_HOST}@" ${MANIFESTS}/acmeair-authservice-route.yaml
fi

kubectl apply -f ${MANIFESTS}

echo "Removing ${IMAGE_PREFIX}"
sed -i.bak "s@${IMAGE_PREFIX}/acmeair-authservice-java-s390x:latest@acmeair-authservice-java-s390x:latest@" ${MANIFESTS}/deploy-acmeair-authservice-java.yaml

echo "Removing ${ROUTE_HOST}"
sed -i.bak "s@${ROUTE_HOST}@_HOST_@" ${MANIFESTS}/acmeair-authservice-route.yaml

cd ../acmeair-bookingservice-java
kubectl delete -f ${MANIFESTS}

if [[ `grep -c ${IMAGE_PREFIX} ${MANIFESTS}/deploy-acmeair-bookingservice-java.yaml` == 0 ]]
then
  echo "Adding ${IMAGE_PREFIX}/"
  sed -i.bak "s@acmeair-bookingservice-java-s390x:latest@${IMAGE_PREFIX}/acmeair-bookingservice-java-s390x:latest@" ${MANIFESTS}/deploy-acmeair-bookingservice-java.yaml
fi

if [[ `grep -c ${ROUTE_HOST} ${MANIFESTS}/acmeair-bookingservice-route.yaml` == 0 ]]
then
  echo "Patching Route Host: ${ROUTE_HOST}"
  sed -i.bak "s@_HOST_@${ROUTE_HOST}@" ${MANIFESTS}/acmeair-bookingservice-route.yaml
fi

kubectl apply -f ${MANIFESTS}

echo "Removing ${IMAGE_PREFIX}"
sed -i.bak "s@${IMAGE_PREFIX}/acmeair-bookingservice-java-s390x:latest@acmeair-bookingservice-java-s390x:latest@" ${MANIFESTS}/deploy-acmeair-bookingservice-java.yaml

echo "Removing ${ROUTE_HOST}"
sed -i.bak "s@${ROUTE_HOST}@_HOST_@" ${MANIFESTS}/acmeair-bookingservice-route.yaml

cd ../acmeair-customerservice-java
kubectl delete -f ${MANIFESTS}

if [[ `grep -c ${IMAGE_PREFIX} ${MANIFESTS}/deploy-acmeair-customerservice-java.yaml` == 0 ]]
then
  echo "Adding ${IMAGE_PREFIX}/"
  sed -i.bak "s@acmeair-customerservice-java-s390x:latest@${IMAGE_PREFIX}/acmeair-customerservice-java-s390x:latest@" ${MANIFESTS}/deploy-acmeair-customerservice-java.yaml
fi

if [[ `grep -c ${ROUTE_HOST} ${MANIFESTS}/acmeair-customerservice-route.yaml` == 0 ]]
then
  echo "Patching Route Host: ${ROUTE_HOST}"
  sed -i.bak "s@_HOST_@${ROUTE_HOST}@" ${MANIFESTS}/acmeair-customerservice-route.yaml
fi

kubectl apply -f ${MANIFESTS}

echo "Removing ${IMAGE_PREFIX}"
sed -i.bak "s@${IMAGE_PREFIX}/acmeair-customerservice-java-s390x:latest@acmeair-customerservice-java-s390x:latest@" ${MANIFESTS}/deploy-acmeair-customerservice-java.yaml

echo "Removing ${ROUTE_HOST}"
sed -i.bak "s@${ROUTE_HOST}@_HOST_@" ${MANIFESTS}/acmeair-customerservice-route.yaml

cd ../acmeair-flightservice-java
kubectl delete -f ${MANIFESTS}

if [[ `grep -c ${IMAGE_PREFIX} ${MANIFESTS}/deploy-acmeair-flightservice-java.yaml` == 0 ]]
then
  echo "Adding ${IMAGE_PREFIX}/"
  sed -i.bak "s@acmeair-flightservice-java-s390x:latest@${IMAGE_PREFIX}/acmeair-flightservice-java-s390x:latest@" ${MANIFESTS}/deploy-acmeair-flightservice-java.yaml
fi

if [[ `grep -c ${ROUTE_HOST} ${MANIFESTS}/acmeair-flightservice-route.yaml` == 0 ]]
then
  echo "Patching Route Host: ${ROUTE_HOST}"
  sed -i.bak "s@_HOST_@${ROUTE_HOST}@" ${MANIFESTS}/acmeair-flightservice-route.yaml
fi

kubectl apply -f ${MANIFESTS}

echo "Removing ${IMAGE_PREFIX}"
sed -i.bak "s@${IMAGE_PREFIX}/acmeair-flightservice-java-s390x:latest@acmeair-flightservice-java-s390x:latest@" ${MANIFESTS}/deploy-acmeair-flightservice-java.yaml

echo "Removing ${ROUTE_HOST}"
sed -i.bak "s@${ROUTE_HOST}@_HOST_@" ${MANIFESTS}/acmeair-flightservice-route.yaml
