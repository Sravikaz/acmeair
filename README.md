# Acme Air setup for Openshift

The following describe necessary steps to run on Acme-Air workload on openshift.

## Setting up Image repository using Artifactory
Only do this step if you do not have acces to our internal build [here](https://na.artifactory.swg-devops.com/artifactory/webapp/#/artifacts/browse/tree/General/sys-ltic-docker-local/acmeair)
1. Clone this repo.
2. Create artifactory or other repository hub and get pull secret. Edit acmeair-mainservices-java/scripts/buildAndPushtoICP.sh with `Cluster=<your artifactory url>`. Run script then wait while images are set up on artifactory.

*note internally we have travis automation to autimatically update terraform images upon new push to this repo*

## Connecting Openshift to AcmeAir
1. Obtain access to both openshift gui and cli. Open gui via Openshift online link or by running ` echo "https://$(grep console /etc/hosts | cut -d' ' -f 4 | awk '/./{line=$0} END{print line}')"` to get url. Use the  "Copy Login Command" from dropdown under your name in the upper right hand corner to get a command to login to your cluster via command line. Run an `oc status` to check that you are logged in. If you are in another cluster Download kubectx from https://github.com/ahmetb/kubectx . Run `kubectx` to check that you are in your proper openshift context to not default (openshift will not run in default context).
2. On the web ui create project and login to that project using `oc login`
3. In terminal Run `/acmeair-mainservices-java/scripts/.deployToopenshift.sh` to create deployments for all of the services required for Acme air. 
4. Wait a couple minutes and go to http://proxy_ip/acmeair
Go to the Configuration Page and Load the Database
