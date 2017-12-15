#!/bin/bash
# curlESToken

DEFAULT_HOST="localhost"
DEFAULT_PORT="8850"

function urlencode {
	local LANG=C
	for ((i=0;i<${#1};i++)); do
		if [[ ${1:$i:1} =~ ^[a-zA-Z0-9\.\~\_\-]$ ]]; then
			printf "${1:$i:1}"
		else
			printf '%%%02X' "'${1:$i:1}"
		fi
	done
}

# ------------------- Parameter control for host and port --------------------
if [ -n "$1" ]
then
  HOST=$1
else
  HOST=$DEFAULT_HOST
fi

if [ -n "$2" ]
then
  PORT=$2
else
  PORT=$DEFAULT_PORT
fi

# ------------------- Parameter control for host and port --------------------
echo "Target host is: $HOST"

SHORT_TOKEN=$(curl "$HOST:$PORT/es/api/authenticate" -X POST -H 'authorization: Basic YWRtaW46YWRtaW4=' -H 'cache-control: no-cache' | cut -d ":" -f2 | sed -e 's/\}//g')
echo "-----------------------"
echo "Short token :$SHORT_TOKEN"
echo "-----------------------"

LONG_TOKEN=$(curl "$HOST:$PORT/es/api/authenticate"  -X POST -H 'cache-control: no-cache' -H 'content-type: application/json' -d '{ "identity": '$SHORT_TOKEN'}' | cut -d ":" -f2 | sed -e 's/\}//g' -e 's/\"//g')
echo "-----------------------"
echo "Long token: $LONG_TOKEN"
echo "-----------------------"

SESSION=$(curl "$HOST:$PORT/api/session?i=Kr2sTBgNPVc2re99ym9jkDA1PxRXLeefTlD5ldRdDTZO0TXi05vw7w%3D%3D" -v -H 'cache-control: no-cache' -H 'content-type: application/json' -d '{"accountId": 1, "applicationInstance": "eptica_default"}' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/51.0.2704.79 Chrome/51.0.2704.79 Safari/537.36' )
echo "-----------------------"
echo "SESISON: $SESSION"
echo "-----------------------"
