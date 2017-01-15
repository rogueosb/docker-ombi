#Ombi Docker Image
A docker image for [Ombi](https://github.com/tidusjar/Ombi).

#Usage

    docker run -d -i --name ombi --restart=always -p "3579:3579" -v /your-config-location:/config rogueosb/ombi

To circumvent GitHub API rate limiting, you can use the environment label API by adding: `-e API=username:accesstoken` to your run command. You can get your Personal Access Token from [here](https://github.com/settings/tokens).

If you would like to use the Dev branch (at your own risk!), add `-e DEV=1` to your run command.

##Changes
- **06/04/2016:** Fix for version 1.60 config location
- **25/05/2016:** Update for backups in 1.7.0
- **01/07/2016:** Fix wrong download URL
- **26/07/2016:** Add dev branch environment variable
- **19/12/2016:** Changes to reflect new name (Ombi)
- **20/12/2016:** Further changes for Ombi, added GitHub API login
- **15/01/2017:** Changes for Ombi v2 (migrate db, new exe filename)
