#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

cp $SCRIPT_DIR/org.rfcx.exo.plist ~/Library/LaunchAgents/.;

launchctl load -w ~/Library/LaunchAgents/org.rfcx.exo.plist;