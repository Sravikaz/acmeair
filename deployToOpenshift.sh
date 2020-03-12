#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"	
sh $DIR/acmeair-mainservice-java/scripts/deployToOpenshift.sh $1
