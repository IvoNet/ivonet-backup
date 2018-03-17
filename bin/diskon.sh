#!/usr/bin/env bash
gpio mode 0 out
gpio -g write 17 1
sleep 1
gpio -g write 17 0