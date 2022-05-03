## MIT App Inventor Docker Image

### Building the image from DockerHub

#### Running the Image Locally
The easiest way to run the image is to create a basic docker-compose file:
```yml
version: '3.8'

services:

  aia:
    restart: always
    build:
      context: .
    ports:
      - "9876:9876"
      - "8888:8888"
      - "9990:9990"
```
And to run it:
```
sudo docker-compose up --build up
```
#### Usage
##### 1. Running the BuildServer
```
sudo docker exec ${CONTAINER_ID} bash -c "cd buildserver && ant RunLocalBuildServer"
```
##### 2. Running the MainServer
```
sudo docker exec text2app_aia_1 bash -c "/opt/appengine/appengine-java-sdk-1.9.68/bin/dev_appserver.sh --port=8888 --address=0.0.0.0 appengine/build/war/"
```
##### 3. Building APK file
```bash
app_name=$1
zip_name=$2
bash zipper.sh ${app_name} ${zip_name}
sudo docker cp ./$2 text2app_aia_1:/home/Text2App/appinventor/buildserver/
sudo docker exec text2app_aia_1 bash -c "cd /home/Text2App/appinventor/buildserver/ && ant RunMain -Dzip.file=./${zip_name} -Duser.name=t2a -Doutput.dir=./"
sudo docker cp text2app_aia_1:/home/Text2App/appinventor/buildserver/${app_name}.apk ./${app_name}.apk
```


### Building the image from Source

#### Prerequisite
- Docker and docker-compose needs to be installed in the system
#### Steps
1. Clone this repo
```
git clone git@github.com:ashiqursuperfly/appinventor-docker-image.git
```
2. Run the `build_aia_image.sh`
```
bash build_aia_image.sh
```