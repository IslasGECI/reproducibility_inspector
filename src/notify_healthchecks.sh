#!/usr/bin/env bash
#
# Notifica a Healthchecks.io

function notify_healthchecks {
  curl \
    --data-raw "$2" \
    --fail \
    --max-time 10 \
    --retry 5 \
    --show-error \
    --silent \
    https://hc-ping.com/"$1"
}
