#!/bin/bash
export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
cd "/Users/TUM/Desktop/USC Minijob Tracker" || exit 1

PID_FILE=".server.pid"

if [[ ! -f "$PID_FILE" ]]; then
  echo "Kein laufender Trainings-Tracker-Server gefunden."
  exit 0
fi

PID=$(cat "$PID_FILE" 2>/dev/null)
if [[ -n "$PID" ]] && kill -0 "$PID" 2>/dev/null; then
  kill "$PID"
  sleep 1
  if kill -0 "$PID" 2>/dev/null; then
    kill -9 "$PID" 2>/dev/null
  fi
  echo "Server gestoppt."
else
  echo "PID-Datei gefunden, aber Prozess laeuft nicht mehr."
fi

rm -f "$PID_FILE"
