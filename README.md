# Deploying Acme Air on Openshift

The following describe necessary steps to run on Acme-Air workload on openshift.

## Setting up Image repository using Artifactory
1. Clone this repo*.
2. Create artifactory or other repository hub. Only do this step if you do not have acces to our internal build [here](https://na.artifactory.swg-devops.com/artifactory/webapp/#/artifacts/browse/tree/General/sys-ltic-docker-local/acmeair)
3. Get pull secret from registry.
4. Add pull secret to openshift with
```
oc create secret docker-registry <pull_secret_name> \
    --docker-server=<registry_server> \
    --docker-username=<user_name> \
    --docker-password=<password> \
    --docker-email=<email>
  ```
  and make sure to add the secret to your secive account (probably default)
  ` oc secrets add serviceaccount/default secrets/<pull_secret_name> --for=pull `
  
5. If not using our internal registry, edit acmeair-mainservices-java/scripts/buildAndPushtoOpenshift.sh with `Cluster=<your artifactory url>`. 

*Internally we have travis automation to autimatically update terraform images upon new push to this repo.*

## Connecting Openshift to AcmeAir 4.

1. Obtain access to both openshift gui and cli. Open gui via Openshift online link or by running ` echo "https://$(grep console /etc/hosts | cut -d' ' -f 4 | awk '/./{line=$0} END{print line}')"` to get url. Use the  "Copy Login Command" from dropdown under your name in the upper right hand corner to get a command to login to your cluster via command line. Run an `oc status` to check that you are logged in. If you are in another cluster Download kubectx from https://github.com/ahmetb/kubectx . Run `kubectx` to check that you are in your proper openshift context to not default (openshift will not run in default context).
2. On the web ui create project and login to that project using `oc login`
3. In terminal Run `/acmeair-mainservices-java/scripts/.deployToOpenshift.sh` to create deployments for all of the services required for Acme air. 
4. View running services with `oc get services`
5. Add route to mainservice with `oc expose service acmeair-main-service --name=acmeair-main-route --port=9080`
6. Get auto generated url with `oc describe route acmeair-main-route` and add to /etc/hosts so that it resolves to the same ip as your openshift cluster gui command center.
7. Wait a couple minutes and go to http://<auto_generated_url>/acmeair
8. Go to the Configuration Page and Load the Database

Note: If your mongodb containers are failing its probably because you have an openshift policy demanding all containers run as nonroot. This can be fixed with `oc adm policy add-scc-to-group`.
