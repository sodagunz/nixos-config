#!/usr/bin/env bash

pkill swaybg 2>/dev/null || true
swaybg -i "$1" -m fill &
