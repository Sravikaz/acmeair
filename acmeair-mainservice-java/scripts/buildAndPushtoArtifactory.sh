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

if [[ "${1}" == "--with-microclimate" ]]
then
  DOCKERFILE=Dockerfile
  CLUSTER=${2:-mycluster.icp}
elif [[ "${1}" == "--open-liberty" ]]
then
  DOCKERFILE=Dockerfile-ol-base
  CLUSTER=${2:-mycluster.icp}
else
  DOCKERFILE=Dockerfile-base
  CLUSTER=sys-ltic-docker-local.artifactory.swg-devops.com
fi

cd "$(dirname "$0")"
cd ..
mvn clean package

docker build --pull -t ${CLUSTER}/${NAMESPACE}/acmeair-mainservice-java -f ${DOCKERFILE} .
docker push ${CLUSTER}/${NAMESPACE}/acmeair-mainservice-java

cd ../acmeair-authservice-java
mvn clean package
docker build --pull -t ${CLUSTER}/${NAMESPACE}/acmeair-authservice-java -f ${DOCKERFILE} .
docker push ${CLUSTER}/${NAMESPACE}/acmeair-authservice-java

cd ../acmeair-bookingservice-java
mvn clean package
docker build --pull -t ${CLUSTER}/${NAMESPACE}/acmeair-bookingservice-java -f ${DOCKERFILE} .
docker push ${CLUSTER}/${NAMESPACE}/acmeair-bookingservice-java

cd ../acmeair-customerservice-java
mvn clean package
docker build --pull -t ${CLUSTER}/${NAMESPACE}/acmeair-customerservice-java -f ${DOCKERFILE} .
docker push ${CLUSTER}/${NAMESPACE}/acmeair-customerservice-java

cd ../acmeair-flightservice-java
mvn clean package
docker build --pull -t ${CLUSTER}/${NAMESPACE}/acmeair-flightservice-java -f ${DOCKERFILE} .
docker push ${CLUSTER}/${NAMESPACE}/acmeair-flightservice-java
