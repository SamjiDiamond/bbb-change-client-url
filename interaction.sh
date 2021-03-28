#!/bin/sh
##
# @Description: This script is produce to make changing of client url easy as ABC
# Author: Odejinmi Samuel ~ Samji
##
# To know your old name easily
#yq r /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml public.app.basename
##

echo I am about to help you change your client url
echo What is the old name e.g html5client?
read oldname

echo What is the new name e.g meeting?
read newname

echo "from $oldname"
echo "to $newname"
if [ "$oldname" == "" ]; then 
        echo "You must specify a valid old name (like the name given in the docs)."
        echo "I will not be able to help you further"
        return
fi

if [ "$newname" == "" ]; then 
    err "You must specify a valid new name (the name you want your meeting like to change to)."
    echo "I will not be able to help you further"
    return
fi

##Change the default path for HTML5 client

echo " -Changing ${oldname} in the config settings to ${newname}"
TARGET=/usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
yq w -i $TARGET public.app.basename ${newname}

echo "  - changing ${oldname} in nginx to ${newname}"
TARGET=/etc/bigbluebutton/nginx/bbb-html5.nginx
sed -i "s|$oldname|$newname|g" $TARGET

echo "  - changing ${oldname} to ${newname} in bigbluebutton properties"
TARGET=/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
sed -i "s|$oldname|$newname|g" $TARGET

echo "  - changing ${oldname} to ${newname} in system start"
TARGET=/usr/share/meteor/bundle/systemd_start.sh
sed -i "s|$oldname|$newname|g" $TARGET


echo "  - changing ${oldname} to ${newname} in frontend"
TARGET=/usr/share/meteor/bundle/systemd_start_frontend.sh
sed -i "s|$oldname|$newname|g" $TARGET

sudo service nginx reload && sudo bbb-conf --restart

echo "*************Thanks for using me************"
echo "Give SamjiDiamond a star on github"
