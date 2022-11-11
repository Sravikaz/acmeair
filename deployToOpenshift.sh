#!/bin/bash

oc create sa sa-with-anyuid
oc adm policy add-scc-to-user anyuid -z sa-with-anyuid

if [ $NFS_PV || $CEPHFS_PV ]; then
  #Add nfs persistent volume claims to application:
  export MANIFESTS=manifests-openshift-nfs
fi


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"	
sh $DIR/acmeair-mainservice-java/scripts/deployToOpenshift.sh $1
unset MANIFESTS
