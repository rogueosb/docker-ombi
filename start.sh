#!/bin/sh

plex_remote="$(curl -sX GET https://api.github.com/repos/tidusjar/PlexRequests.Net/releases/latest | awk '/tag_name/{print $4;exit}' FS='[""]')"

# check for original config file in app dir
if [ -f /app/PlexRequests.Net/PlexRequests.sqlite && ! -f /config/PlexRequests.Net/PlexRequests.sqlite ]; then
  mv /app/PlexRequests.Net/PlexRequests.sqlite /config/PlexRequests.sqlite
fi

rm -rf /app/PlexRequests.Net
curl -o /tmp/plexrequestsnet.zip -L https://github.com/tidusjar/PlexRequests.Net/releases/download/"$plex_remote"/PlexRequests.zip
unzip -o /tmp/plexrequestsnet.zip -d /tmp

mv /tmp/Release /app/PlexRequests.Net
rm /tmp/plexrequestsnet.zip

cd /config

if [ ! -f /config/PlexRequests.sqlite ]; then
  sqlite3 PlexRequests.sqlite "create table aTable(field1 int); drop table aTable;" # create empty db
fi

ln -s /config/PlexRequests.sqlite /app/PlexRequests.Net/PlexRequests.sqlite

mono /app/PlexRequests.Net/PlexRequests.exe
