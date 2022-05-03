app_name=$1
zip_name=$2
container_id=$3
bash zipper.sh ${app_name} ${zip_name}
sudo docker cp ./${zip_name} ${container_id}:/home/Text2App/appinventor/buildserver/
sudo docker exec ${container_id} bash -c "cd /home/Text2App/appinventor/buildserver/ && ant RunMain -Dzip.file=./${zip_name} -Duser.name=t2a -Doutput.dir=./"
sudo docker cp ${container_id}:/home/Text2App/appinventor/buildserver/${app_name}.apk ./${app_name}.apk