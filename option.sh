#!/bin/bash
##
# @Description: This script is produce to make changing of client url easy as ABC
# Author: Odejinmi Samuel ~ Samji
##

function show_usage (){
    printf "Usage: changeclient.sh -c html5client -n rommy\n"
    printf "\n"
    printf "Options:\n"
    printf " -c|--current, The current client url\n"
    printf " -n|--new , The new client url you want\n"
    printf " -h|--help, Print help\n"

return 0
}

while [ ! -z "$1" ]; do
  case "$1" in
     --current|-c)
         shift
         OLDNAME=$1
         echo "You entered current as: $1"
         ;;
     --new|-n)
         shift
         NEWNAME=$1
         echo "You entered new as: $1"
         ;;
     --help|-h)
        shift
        echo "You requested for help"
        show_usage
         ;;
     *)
        show_usage
        ;;
  esac
shift
done


if [ "$OLDNAME" == "" ]; then 
        echo "You must specify a valid old name (like the name given in the docs)."
        show_usage
        return
fi

if [ "$NEWNAME" == "" ]; then 
    err "You must specify a valid new name (the name you want your meeting like to change to)."
    show_usage
    return
fi


##Change the default path for HTML5 client

echo " -Changing ${OLDNAME} in the config settings to ${newname}"
TARGET=/usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
yq w -i $TARGET public.app.basename ${NEWNAME}

echo "  - changing ${OLDNAME} in nginx to ${NEWNAME}"
TARGET=/etc/bigbluebutton/nginx/bbb-html5.nginx
sed -i "s|$OLDNAME|$NEWNAME|g" $TARGET

echo "  - changing ${OLDNAME} to ${NEWNAME} in bigbluebutton properties"
TARGET=/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
sed -i "s|$OLDNAME|$NEWNAME|g" $TARGET

echo "  - changing ${OLDNAME} to ${NEWNAME} in system start"
TARGET=/usr/share/meteor/bundle/systemd_start.sh
sed -i "s|$OLDNAME|$NEWNAME|g" $TARGET


echo "  - changing ${OLDNAME} to ${NEWNAME} in frontend"
TARGET=/usr/share/meteor/bundle/systemd_start_frontend.sh
sed -i "s|$OLDNAME|$NEWNAME|g" $TARGET

sudo service nginx reload && sudo bbb-conf --restart

echo "*************Thanks for using me************"
echo "Give SamjiDiamond a star on github"
