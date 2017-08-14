# Ombi Docker Image
A docker image for [Ombi](https://github.com/tidusjar/Ombi).

# Usage

    docker run -d -i --name ombi --restart=always -p "3579:3579" -v /your-config-location:/config rogueosb/ombi

### Environment Variables
You can run the image with the following environment labels:

| Environment Label | Function |
|-------------------|----------|
| `-e DEV=1` OR `-e EAP=1` | Use the latest dev or Early Access Preview (EAP) build. |
| `-e API=username:accesstoken` | Circumvent GitHub API rate limiting. <br>Use your GitHub username and a Personal Access Token from [here](https://github.com/settings/tokens). |
| `-e PUID=1000`<br>`-e PGID=1000` | Set user and group ID to run container as. |
| `-e RUN_OPTS="-base /ombi"` | Pass run commands to Ombi.exe in the container. Example given for baseurl setting. |


## Changes
- **06/04/2016:** Fix for version 1.60 config location
- **25/05/2016:** Update for backups in 1.7.0
- **01/07/2016:** Fix wrong download URL
- **26/07/2016:** Add dev branch environment variable
- **19/12/2016:** Changes to reflect new name (Ombi)
- **20/12/2016:** Further changes for Ombi, added GitHub API login
- **15/01/2017:** Changes for Ombi v2 (migrate db, new exe filename)
- **18/01/2017:** Added support for PUID/PGID environment labels
- **23/01/2017:** Added EAP support (thanks, karbowiak!)
