#!/usr/bin/with-contenv bash

identifier="tidusjar/Ombi"
filename="linux.tar.gz"
zip_path="/tmp/linux.tar.gz"
user_details=""

PUID=${PUID:-9001}
PGID=${PGID:-9001}

groupmod -o -g "$PGID" ombi
usermod -o -u "$PUID" ombi

if [ -z ${API+x} ]; then
  echo "no API login used"
else
  echo "using provided API details"
  user_details="-u $API"
fi

ombi_latest=$(curl $user_details -sX GET https://api.github.com/repos/$identifier/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

rm -rf /app/Ombi
mkdir -p /app/Ombi

if [ "$DEV" = "1" ]; then
  echo "Getting Development Version";
  /usr/bin/python /get-dev.py
elif [ "$EAP" = "1" ]; then
  echo "Getting Early Access Preview";
  /usr/bin/python /get-eap.py
else
  echo "Getting Stable Version ($ombi_latest)";
  /usr/bin/curl -o $zip_path -L  "https://github.com/tidusjar/Ombi/releases/download/$ombi_latest/linux.tar.gz"
fi

echo "Unzipping...";
tar xfz $zip_path -C /app/Ombi

rm $zip_path
chmod +x /app/Ombi/Ombi

chown -R ombi:ombi /app
chown -R ombi:ombi /config

cd /app/Ombi
exec s6-setuidgid ombi /app/Ombi/Ombi --storage "/config" --host http://*:3579 ${RUN_OPTS}
