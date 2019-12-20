# Deploying Acme Air on Openshift

The following describe neccessary steps to run on Acme-Air workload on openshift.
This "Hard Coded" branch for easy sripts to use the sys-loz-test-team-docker-local.artifactory

## Connecting Openshift to AcmeAir, pulling from Artifactory 

Prerequisits:
 - Logged onto Openshift cluster
 - Access to sys-loz-test-team-docker-local.artifactory.swg-devops.com
 
1. `oc login`
2. Login to https://eu.artifactory.swg-devops.com get copy api key(from account settings in top right).
3. Add pull secret to openshift project. First test connection on your local machine by running `docker login sys-loz-test-team-docker-local.artifactory.swg-devops.com  -u <email> -p <api key> 
If docker was successfully logged in then you have access to private regitry. Easiest way to add access to your openshift project is to run`oc create secret generic loz-artifactory --from-file=.dockerconfigjson=.docker/config.json --type=kubernetes.io/dockerconfigjson` this uses all the keys to private image registries so be careful. Alternative solutions: https://docs.openshift.com/container-platform/4.2/openshift_images/managing-images/using-image-pull-secrets.html
Now add the secret to the default service account to use in building your images: `oc secrets link default loz-artifactory `
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
Remember to push with [ci skip] if updating README so that travis doesn't make a bunch of needless builds.
