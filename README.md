# Infomaniak-RetrieveWebLogs
Collection of bash scripts allowing the daily download of the access.log &amp; error.log for a given Infomaniak hosted site. 

## Prerequisites
Just a *nix machine running 24/7 with some disk space (and bash & python, but this should be an issue...).

## Getting started
1. Place the files on your Linux box (e.g. your local NAS, a Raspberry Pi etc.).
2. Edit files Infomaniak-RetrieveWebLogs-Daily.sh & Start_Infomaniak-RetrieveWebLogs-Daily.sh to update the following placeholders:
	- [PATH_TO_SCRIPT_FOLDER] = Unix path to your script folder (e.g. /home/pi/Infomaniak-RetrieveWebLogs/).
	- [PATH_TO_LOG_FOLDER] = Unix path to the folder where the logs will be stored (e.g. /var/logs/Infomaniak-RetrieveWebLogs/).
	- [INFOMANIAK_MANAGER_EMAIL] & [INFOMANIAK_MANAGER_PASSWORD] = The email address and password of a user allowed to log into the Infomaniak Manager to view the web logs.
	- [INFOMANIAK_CUSTOMER_IDS] = Log into the Infomaniak Manager (https://manager.infomaniak.com), select the old admin interface and browse to your web hosting. The URL in the browser should now feature an URL such as ```https://manager.infomaniak.com/hebergement/index.php/gNNNNsNiNNN``` where N are numbers. Use ```gNNNNsNiNNN``` as ```INFOMANIAK_CUSTOMER_IDS```.
	- [INFOMANIAK_SITE_ID] = From the page above, click Option "Access and Error Logs" and download a file. Inspect the download URL and extract the value of parameter ```iSite```.
3. Ensure exec rights are correctly set for the various scripts (chmod +x)
4. Run the script once using ```Start_Infomaniak-RetrieveWebLogs-Daily.sh```
