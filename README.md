# Deploying Acme Air on Openshift
Acme Air workload, configured to run on Openshift on Z. The Acme Air workload models a Flight booking system for the fictional Acme Air company. See upstream source at https://github.com/blueperf/acmeair-mainservice-java for running on other plaforms than OCP. Once deployed, access Acmeair application by going to https://<your_custom_domain>/acmeair . To simulate many customers interating with the system use Acmeair-driver https://github.ibm.com/OpenShift-on-Z/Acmeair-driver .

## Connecting Openshift to AcmeAir, pulling from Artifactory 

### Prerequisites:
 - Logged onto Openshift cluster
 - Access to one of the internal artifactory registries hosting Acmeair images. 
 (Note: To build with internal registry go to blue perf's official Acmeair and follow those instructions instead)
 
### Step by step
1. `oc login` then 
2. Login to https://eu.artifactory.swg-devops.com and copy your api key (from account settings in top right).
3. Add pull secret to openshift project. You can first test connection on your local machine by running `docker login sys-loz-test-team-docker-local.artifactory.swg-devops.com  -u <email> -p <api key> `. Or changing "sys-loz..." to your registry url.
4. If docker was successfully logged in then you have access to the private regitry. Easiest way to add access to your openshift project is to run
```
oc create secret docker-registry sys-loz-artifactory \
 --docker-server=sys-loz-test-team-docker-local.artifactory.swg-devops.com \
--docker-username=<your_email> \
--docker-password=<your_api_key> 
```
Now add the secret to the default service account to use in building your images: `oc secrets link default sys-loz-artifactory --for=pull `

5. Clone this code repository to the machine logged into Openshift cluster.
6. By default openshift does not allow containers running as root. Right now the mongoDB container runs as root so be sure to `oc adm policy add-scc-to-group anyuid system:authenticated  ` so that the db containers can run.
7. Run `sh ./acmeair-mainservice-java/scripts/deployToOpenshift.sh <YOUR_CUSTOM_ROUTENAME>` to create deployments for all of the services required for Acme air. If no route name is given then default route name "defaultacmeair.com" will be given.
8. Add your custom routename to /etc/hosts so that it resolves to the your openshift bastion.
9. Wait a couple seconds and go to http://<YOUR_CUSTOM_ROUTENAME>/acmeair in your browser.
Have fun booking your vacation flights!

### Using Acme Air
One you have access to the Acme Air webpage:
- First load the database by clicking "configure the acmeair environment" -> "Load the database" and enter the DB size.
- To book flights first Login, then click Flights to book your flight. If you don't find any flights keep trying new combinations.
- To inspect airline information click "configure the acmeair environment" -> "Runtime Info". This is useful for testing Acmeair driver.
- Go to https://github.ibm.com/OpenShift-on-Z/Acmeair-driver to configure acmeair-driver code.

### Troubleshooting
- If /acmeair works in browser but you get a 404 for another subdomain your routes are configured incorrectly. Check that each pod is running by going to your url followed by /auth,/booking,/customer,/flight and /acmeair.
- If you getting 403 errors you forgot to click logon
Note: If your mongodb containers are failing its probably because you have an openshift policy demanding all containers run as nonroot. This can be fixed with `oc adm policy add-scc-to-group`.

### Development Notes
Changes to this codebase are built from travis and pushed to sys-loz-test-team and sys-ltic artifactorys.
Remember to push with [ci skip] if updating README so that travis doesn't make a bunch of needless builds.

# Deploying Acme Air with Docker

### Prerequisites:
 - Access to one of the internal artifactory registries hosting Acmeair images. 
 (Note: To build with internal registry go to blue perf's official Acmeair and follow those instructions instead)
 
### Step by step
1. Long into the docker repository hosting the images by running `docker login sys-loz-test-team-docker-local.artifactory.swg-devops.com  -u <email> -p <api key>`. Or changing "sys-loz..." to your registry url.
2. Clone this code repository to the machine intended to host the services (the example uses localhost)
3. Run `docker-compose up -d` to bring up the acmeair services on the `acmeair` docker network
4. Access the acmeair UI at `http://localhost/acmeair/`

