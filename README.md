# Deploying Acme Air on Openshift

The following describe neccessary steps to run on Acme-Air workload on openshift.

## Connecting Openshift to AcmeAir, pulling from Artifactory 

Prerequisits:
 - Logged onto Openshift cluster
 - Access to sys-loz-test-team-docker-local.artifactory.swg-devops.com
 
1. `oc login`
2. Login to https://eu.artifactory.swg-devops.com get copy api key(from account settings in top right).
3. Add pull secret to openshift project
```
oc create secret docker-registry <pull_secret_name> \
    --docker-server=sys-loz-test-team-docker-local.artifactory.swg-devops.com \
    --docker-username=<user_name> \
    --docker-password=<api_key> \
    --docker-email=<email>
  ```
  and make sure to add the secret to your secive account (probably default)
  ` oc secrets add serviceaccount/default secrets/<pull_secret_name> --for=pull `
4. Pull this repository to the machine logged into Openshift cluster.
5. By default openshift does not allow containers running as root. Right now the mongoDB container runs as root so be sure to `oc adm policy add-scc-to-group anyuid system:authenticated  ` so that the db containers can run.
5. Run `/acmeair-mainservices-java/scripts/deployToOpenshift.sh` to create deployments for all of the services required for Acme air. 
6. Add openshiftacmeair.com to /etc/hosts so that it resolves to the same ip as your openshift cluster gui command center.
7. Wait a couple minutes and go to http://<auto_generated_url>/acmeair
8. Go to the Configuration Page and Load the Database

### Troubleshooting
If /acmeair works in browser but you get a 404 for another subdomain your routes are configured incorrectly. Check that routes resolve /auth,/booking,/customer,/flight, and /  (to main) 
Note: If your mongodb containers are failing its probably because you have an openshift policy demanding all containers run as nonroot. This can be fixed with `oc adm policy add-scc-to-group`.


### Development Notes
Remember to push with [no ci] if updating README so that travis doesn't make a bunch of needless builds.
