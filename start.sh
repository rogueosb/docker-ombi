#!/bin/sh

identifier="tidusjar/Ombi"
filename="Ombi.zip"
zip_path="/tmp/Ombi.zip"
user_details=""

if [ -z ${API+x} ]; then 
  echo "no API login used"
else
  echo "using provided API details"
  user_details="-u $API"
fi

ombi_remote=$(curl $user_details -sX GET https://api.github.com/repos/$identifier/releases/latest | awk '/browser_download_url/{print $4;exit}' FS='[""]')

rm -rf /app/Ombi

if [ "$DEV" = "1" ]; then
  python /get-dev.py
else
  curl -o $zip_path -L "$ombi_remote"
fi

unzip -o $zip_path -d /tmp

mv /tmp/Release /app/Ombi
rm $zip_path

cd /config

if [ ! -f /config/Ombi.sqlite ]; then
  if [ -f /config/PlexRequests.sqlite ]; then # migrate existing db
    mv /config/PlexRequests.sqlite /config/Ombi.sqlite
  else
    sqlite3 Ombi.sqlite "create table aTable(field1 int); drop table aTable;" # create empty db
  fi
fi

# check for Backups folder in config
if [ ! -d /config/Backup ]; then
  echo "Creating Backup dir..."
  mkdir /config/Backup
fi


ln -s /config/Ombi.sqlite /app/Ombi/Ombi.sqlite
ln -s /config/Backup /app/Ombi/Backup

cd /app/Ombi
executable=$(ls | grep ".exe" | grep -v "Updater\|config")
mono $executable "${RUN_OPTS}"
