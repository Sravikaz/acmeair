#Acme Air setup for Openshift

The following describe necessary changes to adapt https://github.com/blueperf/acmeair-mainservice-java to run on openshift.

1. Create new directory `mkdir acme-air` and pull each of the 5 acme-air-java repositories into subdirectories here.

2. Create artifactory repository and get pull secret. Edit then run acmeair-mainservices-java/scripts/buildAndPushtoICP.sh with `Cluster=<your artifactory url>` wait a while then check that all images are now on artifactory.

3. Download and setup kubectx from https://github.com/ahmetb/kubectx . Run `kubectx acmeair` to set context to non default (openshift will not run in default context).
3. Open Openshift web ui. Create project and login to that project with oc. Run .deployToopenshift.sh 
