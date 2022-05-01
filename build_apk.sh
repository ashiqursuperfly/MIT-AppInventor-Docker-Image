app_name=$1
zip_name=$2
bash zipper.sh ${app_name} ${zip_name}
sudo docker cp ./$2 text2app_aia_1:/home/Text2App/appinventor/buildserver/
sudo docker exec text2app_aia_1 bash -c "cd /home/Text2App/appinventor/buildserver/ && ant RunMain -Dzip.file=./${zip_name} -Duser.name=t2a -Doutput.dir=./"
sudo docker cp text2app_aia_1:/home/Text2App/appinventor/buildserver/${app_name}.apk ./${app_name}.apk