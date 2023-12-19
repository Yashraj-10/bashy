#!/bin/bash

year=$(date +'%Y')
month=$(date +'%m')
day=$(date +'%d')

launch_calendar() {
    if command -v "$1" &> /dev/null; then
        "$1" calendar.google.com/calendar/u/1/r/month/$year/$month/$day &> /dev/null 
        exit 0
    fi
}

launch_calendar google-chrome
launch_calendar google-chrome-stable
launch_calendar chrome
launch_calendar firefox
launch_calendar chromium

echo "No supported browser found"
exit 1
