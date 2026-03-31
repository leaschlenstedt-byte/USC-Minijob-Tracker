#!/bin/bash
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
cd "/Users/TUM/Desktop/USC Minijob Tracker" || exit 1

URL="http://127.0.0.1:8000"
/usr/bin/python3 launch_server.py || exit 1

if [[ -d "/Applications/Google Chrome.app" ]]; then
  /usr/bin/open -na "Google Chrome" --args --app="$URL"
else
  /usr/bin/open "$URL"
fi
