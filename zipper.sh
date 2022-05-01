folder_name=$1
zip_name=$2
cd $folder_name
zip -r -D ../${zip_name} *
