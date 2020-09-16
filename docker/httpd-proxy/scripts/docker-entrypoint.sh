#!/bin/bash
set -euo pipefail

# Handle the env var
stats_intval="${STATUS_REFRESH_PERIOD:-1}"
echo "*/${stats_intval} * * * * /opt/bin/stats.sh
# Keep this new line" > /etc/cron.d/status-cron
crontab /etc/cron.d/status-cron

# supervisord
/usr/bin/supervisord -n 