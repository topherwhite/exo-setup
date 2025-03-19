#!/usr/bin/env bash
DATE=$(date)
USER=$(whoami)
purge && echo "$DATE - $USER" > /Users/admin/logtime
