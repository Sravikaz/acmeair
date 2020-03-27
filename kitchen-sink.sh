#Script is used by Kitchen-Sink Test repo. Not to be run on its own
#Creates acmeair project and runs acmeair & acmeairdriver 
cd "$(dirname "$0")""$(dirname "$0")"
sh ./acmeair-mainservice-java/scripts/deployToOpenshift.sh kitchensinkrouteone.com &> /dev/null
oc apply -f ../acmeair-driver/acmeair-driver.yaml
