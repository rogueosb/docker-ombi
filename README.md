#PlexRequests.Net Docker Image
A docker image for [PlexRequests.Net](https://github.com/tidusjar/PlexRequests.Net).

#Usage

    docker run -d -i --name plexrequestsnet --restart=always -p "3579:3579" -v /your-config-location:/config rogueosb/plexrequestsnet

##Changes
- **06/04/2016:** Fix for version 1.60 config location
- **25/05/2016:** Update for backups in 1.7.0
- **01/07/2016:** Fix wrong download URL
