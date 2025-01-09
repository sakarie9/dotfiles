#!/bin/bash

# 获取当前焦点的窗口 ID
focused_window_id=$(swaymsg -t get_tree | jq '.. | select(.focused? == true) | .id')

# 获取 Telegram 窗口的 ID
# telegram_window_id=$(swaymsg -t get_tree | jq '.. | select(.app_id? == "com.ayugram.desktop" or .app_id? == "org.telegram.desktop") | .id')
read -r tg_window_id tg_window_visible tg_scratchpad_state < <(swaymsg -t get_tree | jq -r '.. | select(.app_id? == "com.ayugram.desktop" or .app_id? == "org.telegram.desktop") | "\(.id) \(.visible) \(.scratchpad_state)"')

if [ -z "$tg_window_id" ]; then
  exit 1
fi

if [ "$tg_scratchpad_state" != "none" ]; then
  # 已经在 scratchpad 中了，直接显示
  swaymsg "[con_id=$tg_window_id]" scratchpad show
elif [ "$tg_window_visible" == "true" ]; then
  # 不在 scratchpad，但是可见，直接移动到 scratchpad

  # 将 Telegram 窗口移动到 scratchpad
  swaymsg "[con_id=$tg_window_id]" move scratchpad

  # 将焦点移动回之前的窗口
  swaymsg "[con_id=$focused_window_id]" focus

  # 然后将 Telegram 窗口从 scratchpad 显示到前台
  swaymsg "[con_id=$tg_window_id]" scratchpad show
else
  # 不可见，但也不在 scratchpad
  swaymsg "[con_id=$tg_window_id]" scratchpad show
fi
