#!/bin/bash
set -euo pipefail

# Run crond
confd -onetime -backend env
crontab /etc/cron.d/status-cron

# supervisord
/usr/bin/supervisord -n 