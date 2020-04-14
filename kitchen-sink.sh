#!/bin/bash

# Download the common code library from artifactory
if ! bash ./DownloadCommonCode.sh; then
    echo "Download of Common code failed"
    exit 1
fi

# Download the OC CLI specified in the config.cfg
if ! bash ./Download-OC-CLI.sh; then
    echo "Download of the oc cli failed"
    exit 1
fi

# Set the oc command just downloaded as our global oc
export OC="./oc"

# Pull in all that common code
source "$(dirname "$0")"/common.shlib

# Log into the cluster
if ! oc_login; then
    echo "Failed to login"
    exit 1
fi

# Grab base project name from config.cfg
OCPPRJT_Base=$(config_get ocp_prjt)
if [ -z "$OCPPRJT_Base" ]; then
    echo "no OCP project avaiable"
    exit 1
fi

# Generate specific project name for this test
OCPPRJT="$OCPPRJT_Base-acmeair"

# Delete project if it exists
if ! oc_delete_Project "$OCPPRJT"; then
    echo "oc_delete_Project failed"
    exit 1
fi

# Create the project
if ! oc_create_project "$OCPPRJT"; then
    echo "oc_create_project failed"
    exit 1
fi

# Set project as working project
if ! oc_set_project "$OCPPRJT"; then
    echo "oc_set_project failed"
    exit 1
fi

# Add artifactory pull secret for docker images
if ! oc_add_art_secret; then
    echo "oc_add_art_secret failed"
    exit 1
fi

#########################################
# Start acmeair test code
#########################################

ACMEAIRROUTE=openshiftacmeairkitchentest.notld
sh ./acmeair-mainservice-java/scripts/deployToOpenshift.sh $ACMEAIRROUTE

#make sure all deployments are sucessfully started
acmemicroservices=("acmeair-mainservice" "acmeair-flighservice" "acmeair-customerservice" "acmeair-bookingservice" "acmeair-authservice"
for i in ${acmemicroservices[@]}; do
  if ! oc_wait_deployment_start $i "$OCPPRJT"; then
      echo "Waiting for $i  deployment start failed"
  fi
done
  # now that we know its up and running, we need to wait for how ever long to make sure that it stays running successfully
  
Wait_Time=$(config_get wtc_time)
if [ -z "$Wait_Time" ]; then
    echo "no Wait time avaiable"
    exit 1
fi
# Convert wait time in hours to seconds
Wait_Time=$(( Wait_Time * 3600))
# Find out when we need to stop (current time + wait time both in seconds)
EndTime=$(( SECONDS + Wait_Time ))

while :; do
    # Do my check
		curl -s $ACMEAIRROUTE
    if [ $? - ne 0]; then
        echo "Error: Canot reach acmeair route from jenkins"
        exit 1
    fi
    echo "Acmeair application still running successfully, waiting 5 minutes before checking again"
    # Wait 5 minute to check again
    sleep 300

    # If I am past my wait time, exit 0
    if [[ $EndTime -lt $SECONDS ]]; then
        echo "Completed Wait time with no problems;"
        break
    fi
    echo "End time is: $EndTime; Time is $SECONDS"
done

# Check to see if user wants test to be left or deleted
Cleanup=$(config_get dlt_long)
if [ -z "$Cleanup" ]; then
    echo "no cleanup setting avaiable"
    exit 1
fi

if [[ "$Cleanup" == "True" ]]; then
    # User wants cleanup to happen
    if ! oc_delete_Project "$OCPPRJT"; then
        echo "oc_delete_Project failed"
        exit 1
    fi
fi
