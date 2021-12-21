#!/bin/sh

cd [PATH_TO_LOG_FOLDER]

while true
do
	# Get yesterday's date in a variable
	YESTERDAY=`python [PATH_TO_SCRIPT_FOLDER]/yesterday.py`
	COOKIE=[PATH_TO_SCRIPT_FOLDER]/myCookieJar.txt
	USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.110 Safari/537.36"

	# Added parameter --insecure on 03.07.2019 as the x509 certificate changed and the tricks outlined in the source below did not work :(
	# https://daniel.haxx.se/blog/2018/11/07/get-the-ca-cert-for-curl/
	curl --insecure --cookie-jar $COOKIE -H "Content-Type: application/json;charset=utf-8" --data '{"login":"[INFOMANIAK_MANAGER_EMAIL]","password":"[INFOMANIAK_MANAGER_PASSWORD]","remember_me":"0","recaptcha":""}' --location https://login.infomaniak.com/api/login |  python -c "import sys, json; print json.load(sys.stdin)['data']['redirect'];" | xargs -n 1 curl --cookie $COOKIE --cookie-jar $COOKIE

	
	curl -A "$USER_AGENT" --insecure --cookie $COOKIE --cookie-jar $COOKIE -L https://manager.infomaniak.com/hebergement/tools/logs/[INFOMANIAK_CUSTOMER_IDS]

	# Download the files
	curl -A "$USER_AGENT" --insecure --cookie $COOKIE -O -J -L "https://manager.infomaniak.com/hebergement/tools/logs/ajax.php?action=download&iSite=[INFOMANIAK_SITE_ID]&&sLogType=access&dDate="$YESTERDAY
	curl -A "$USER_AGENT" --insecure --cookie $COOKIE -O -J -L "https://manager.infomaniak.com/hebergement/tools/logs/ajax.php?action=download&iSite=[INFOMANIAK_SITE_ID]&&sLogType=errors&dDate="$YESTERDAY

	# Remove the cookie jar
	rm $COOKIE
	
	# Fix ownership if required
	#chown pi:pi [YOUR_DOMAIN_NAME]-$YESTERDAY-*
	
	# Wait a day
	sleep 1d
done
