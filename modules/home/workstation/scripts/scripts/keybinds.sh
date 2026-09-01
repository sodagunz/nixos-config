#!/usr/bin/env bash

config_file=~/.config/niri/config.kdl
keybinds=$(sed -n '/^[[:space:]]*binds {/,/^[[:space:]]*}/p' "$config_file" | grep -E '^[[:space:]]*[^/[:space:]].*\{')
keybinds=$(echo "$keybinds" | sed -E 's/^[[:space:]]*//; s/[[:space:]]*\{[[:space:]]*/ = /; s/;[[:space:]]*}$//')
rofi -dmenu -theme-str 'window {width: 50%;} listview {columns: 1;}' <<< "$keybinds"
