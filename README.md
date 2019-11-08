# Acme Air setup for Openshift

The following describe necessary steps to run on Acme-Air workload on openshift.

## Setting up Image repository using Artifactory
Only do this step if you do not have acces to our internal build [here](https://na.artifactory.swg-devops.com/artifactory/webapp/#/artifacts/browse/tree/General/sys-ltic-docker-local/acmeair)
1. Create artifactory or other repository hub and get pull secret. Edit acmeair-mainservices-java/scripts/buildAndPushtoICP.sh with `Cluster=<your artifactory url>`. Run script then wait while images are set up on artifactory.

## x86 Cluster deployment

1. On openshift online gui and select "Copy Login Command" from dropdown under your name in the upper right hand corner.
2. Paste in in terminal and run kubectx
3. Download kubectx from https://github.com/ahmetb/kubectx . Run `kubectx` to check that you are in your proper openshift context to not default (openshift will not run in default context).
3. On the web ui create project and login to that project with oc.
4. In terminal Run `/acmeair-mainservices-java/scripts/.deployToopenshift.sh` 

## TODO: Multiarch 
