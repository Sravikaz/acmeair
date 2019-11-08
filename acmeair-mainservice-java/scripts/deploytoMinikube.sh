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
cd ..
kubectl delete -f ${MANIFESTS}
kubectl apply -f ${MANIFESTS}

cd ../acmeair-authservice-java
kubectl delete -f ${MANIFESTS}
kubectl apply -f ${MANIFESTS}

cd ../acmeair-bookingservice-java
kubectl delete -f ${MANIFESTS}
kubectl apply -f ${MANIFESTS}

cd ../acmeair-customerservice-java
kubectl delete -f ${MANIFESTS}
kubectl apply -f ${MANIFESTS}

cd ../acmeair-flightservice-java
kubectl delete -f ${MANIFESTS}
kubectl apply -f ${MANIFESTS}


