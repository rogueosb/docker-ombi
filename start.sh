#!/bin/sh

plex_remote="$(curl -sX GET https://api.github.com/repos/tidusjar/PlexRequests.Net/releases/latest | awk '/tag_name/{print $4;exit}' FS='[""]')"

rm -rf /app/PlexRequests.Net
curl -o /tmp/plexrequestsnet.zip -L https://github.com/tidusjar/PlexRequests.Net/releases/download/"$plex_remote"/PlexRequests.zip
unzip -o /tmp/plexrequestsnet.zip -d /tmp

mv /tmp/Release /app/PlexRequests.Net
rm /tmp/plexrequestsnet.zip

cd /config

mono /app/PlexRequests.Net/PlexRequests.exe
