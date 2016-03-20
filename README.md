#PlexRequests.Net Docker Image
A docker image for [PlexRequests.Net](https://github.com/tidusjar/PlexRequests.Net).

#Usage

    docker run -d -i --name plexrequestsnet --restart=always -p "3579:3579" -v /your-config-location:/config rogueosb/plexrequestsnet
