#!/bin/bash

EEA_URL="http://quan-XPS-8910:8870/ias"
SHORT_TOKEN=$(curl "$EEA_URL/logincheck.action;jsessionid=7D3FD0AED1A93C0AB08890E9713BA13A" -H 'Cookie: _ga=GA1.2.1636568434.1423236154' -H 'Origin: http://qualif.eptica.com' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-US,en;q=0.8,fr-FR;q=0.6,fr;q=0.4' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/51.0.2704.79 Chrome/51.0.2704.79 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: max-age=0' -H 'Referer: http://localhost:8082/ias/login/login.action;jsessionid=7D3FD0AED1A93C0AB08890E9713BA13A' -H 'Connection: keep-alive' --data 'j_username=eea_fr_1&j_password=d47aeacae707730ca274aaf8302b6999&login.submit=Connect' --compressed -D - | grep stoken | cut -d ";" -f1 | cut -d "\"" -f2 | cut -d "=" -f2)
echo "-----------------------"
echo "shorttoken=$SHORT_TOKEN"
echo "-----------------------"
ENCODED_TOKEN=$(./urlencode $SHORT_TOKEN)
RENEWED_TOKEN=$(curl "$EEA_URL/api/authenticate?stoken=$ENCODED_TOKEN" -v -D - | grep stoken | cut -d ";" -f1 | cut -d "\"" -f2 | cut -d "=" -f2)
echo "-----------------------"
echo "renewedtoken=$RENEWED_TOKEN"
echo "-----------------------"
ENCODED_TOKEN=$(./urlencode $RENEWED_TOKEN)
echo "-----------------------"
echo "FINAL_URLENCODED_TOKEN=$ENCODED_TOKEN"
echo "-----------------------"

