container_id=$1
sudo docker exec ${container_id} bash -c "cd buildserver && ant RunLocalBuildServer"