#!/bin/bash
#
# 'get_repos' obtiene lista de repositorios que IslasGECI tiene en Bitbucket.
# La lista de repos la guarda en 'data/repos.json'.

# Set strict mode (http://redsymbol.net/articles/unofficial-bash-strict-mode)
set -euo pipefail

curl --request GET \
  --url 'https://api.bitbucket.org/2.0/repositories/IslasGECI?q=updated_on%20%3E%202019-07-11&sort=-updated_on&pagelen=100' \
  --user ${BITBUCKET_USERNAME}:${BITBUCKET_PASSWORD} \
  --output /workdir/data/repos.json
