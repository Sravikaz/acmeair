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
set -exo pipefail

NAMESPACE="acmeair"
ARCH = uname -m
DOCKERFILE=Dockerfile-base
CLUSTER=${DOCKER_REGISTRY}

cd "$(dirname "$0")"
cd ..
mvn clean package

docker build --pull -t ${CLUSTER}/${NAMESPACE}/acmeair-mainservice-java-${ARCH}:${TRAVIS_BUILD_ID} -f ${DOCKERFILE} .
docker push ${CLUSTER}/${NAMESPACE}/acmeair-mainservice-java-${ARCH}:${TRAVIS_BUILD_ID}

cd ../acmeair-authservice-java
mvn clean package
docker build --pull -t ${CLUSTER}/${NAMESPACE}/acmeair-authservice-java-${ARCH}:${TRAVIS_BUILD_ID} -f ${DOCKERFILE} .
docker push ${CLUSTER}/${NAMESPACE}/acmeair-authservice-java-${ARCH}:${TRAVIS_BUILD_ID}

cd ../acmeair-bookingservice-java
mvn clean package
docker build --pull -t ${CLUSTER}/${NAMESPACE}/acmeair-bookingservice-java-${ARCH}:${TRAVIS_BUILD_ID} -f ${DOCKERFILE} .
docker push ${CLUSTER}/${NAMESPACE}/acmeair-bookingservice-java-${ARCH}:${TRAVIS_BUILD_ID}

cd ../acmeair-customerservice-java
mvn clean package
docker build --pull -t ${CLUSTER}/${NAMESPACE}/acmeair-customerservice-java-${ARCH}:${TRAVIS_BUILD_ID} -f ${DOCKERFILE} .
docker push ${CLUSTER}/${NAMESPACE}/acmeair-customerservice-java-${ARCH}:${TRAVIS_BUILD_ID}

cd ../acmeair-flightservice-java
mvn clean package
docker build --pull -t ${CLUSTER}/${NAMESPACE}/acmeair-flightservice-java-${ARCH}:${TRAVIS_BUILD_ID} -f ${DOCKERFILE} .
docker push ${CLUSTER}/${NAMESPACE}/acmeair-flightservice-java-${ARCH}:${TRAVIS_BUILD_ID}
