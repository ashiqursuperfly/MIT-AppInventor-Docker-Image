container_id=$1
sudo docker exec ${container_id} bash -c "/opt/appengine/appengine-java-sdk-1.9.68/bin/dev_appserver.sh --port=8888 --address=0.0.0.0 appengine/build/war/"