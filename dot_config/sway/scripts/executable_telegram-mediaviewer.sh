#!/usr/bin/env bash

current_output=$(swaymsg -t get_outputs | jq 'map(.focused) | index(true)')

swaymsg "[app_id=org.telegram.desktop title=媒体查看器]" move output "$current_output"
