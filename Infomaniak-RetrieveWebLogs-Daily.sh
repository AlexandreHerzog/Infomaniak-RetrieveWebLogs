#!/bin/sh

cd [PATH_TO_LOG_FOLDER]

while true
do
	# Get yesterday's date in a variable
	YESTERDAY=`python [PATH_TO_SCRIPT_FOLDER]/yesterday.py`
	COOKIE=[PATH_TO_SCRIPT_FOLDER]/myCookieJar.txt
	curl --cookie-jar $COOKIE -H "Content-Type: application/json;charset=utf-8" --data '{"login":"[INFOMANIAK_MANAGER_EMAIL]","password":"[INFOMANIAK_MANAGER_PASSWORD]","remember_me":"0","recaptcha":""}' --location https://login.infomaniak.com/api/login |  python -c "import sys, json; print json.load(sys.stdin)['data']['redirect'];" | xargs -n 1 curl --cookie $COOKIE --cookie-jar $COOKIE
	
	curl --cookie $COOKIE --cookie-jar $COOKIE -L https://manager.infomaniak.com/hebergement/tools/logs/[INFOMANIAK_CUSTOMER_IDS]

	# Download the files
	curl --cookie $COOKIE -O -J -L "https://manager.infomaniak.com/hebergement/tools/logs/ajax.php?action=download&iSite=[INFOMANIAK_SITE_ID]&&sLogType=access&dDate="$YESTERDAY
	curl --cookie $COOKIE -O -J -L "https://manager.infomaniak.com/hebergement/tools/logs/ajax.php?action=download&iSite=[INFOMANIAK_SITE_ID]&&sLogType=errors&dDate="$YESTERDAY

	# Remove the cookie jar
	rm $COOKIE
	
	# Fix ownership if required
	#chown pi:pi [YOUR_DOMAIN_NAME]-$YESTERDAY-*
	
	# Wait a day
	sleep 1d
done