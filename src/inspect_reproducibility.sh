#!/usr/bin/env bash
#
# Check reproducibility

# Set strict mode (http://redsymbol.net/articles/unofficial-bash-strict-mode)
set -euo pipefail

source /home/ciencia_datos/.vault/.secrets
source /workdir/src/notify_healthchecks.sh

UUID=a55d2311-89dd-4cf1-b5f3-74068147a259

notify_healthchecks "${UUID}/start" "Checking reproducibility"
/workdir/src/get_repos.sh && /workdir/src/crawl_repos.sh \
    && notify_healthchecks "${UUID}" "Reproducibility has been successfully checked" \
    || notify_healthchecks "${UUID}/fail" "Reproducibility was not checked"
