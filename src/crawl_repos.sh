#!/bin/bash
#
# 'crawl_repos' genera los reportes especificados en analyses.json de cada repo.
# La lista de repos la lee de 'data/repos.json'.

function get_report {
      REVISION="$1"
      rm --force analyses.json
      git checkout origin/${REVISION} -- analyses.json
      if [ -f analyses.json ]; then
        REPORTES=$(< analyses.json jq --raw-output '.[].report')
        if [ ! -z "$REPORTES" ]; then
          while read -r REPORTE; do
            echo " "
            echo "geci-testmake $REPO reports/$REPORTE $REVISION"
            /usr/local/bin/geci-testmake $REPO reports/$REPORTE $REVISION
            echo " "
          done <<< "$REPORTES"
        else
          echo "$REVISION no tiene reportes"
        fi
      else
        echo "$REVISION no tiene analyses.json"
      fi
}

cd /workdir/IslasGECI
pwd
REPOS=$(< /workdir/data/repos.json jq --raw-output '.values[] | select(.scm == "git").slug')
while read -r REPO; do
  if [ -d "/workdir/IslasGECI/$REPO" ]; then
    cd /workdir/IslasGECI/$REPO
    pwd
    git fetch
  else
    git clone https://${BITBUCKET_USERNAME}:${BITBUCKET_PASSWORD}@bitbucket.org/IslasGECI/${REPO}.git
    cd /workdir/IslasGECI/$REPO
    pwd
  fi

  git branch --all | grep develop && \
    get_report develop || \
    echo "${REPO}: no tiene rama develop"

 git branch --all | grep main && \
    get_report main || \
    echo "${REPO}: no tiene rama main"

 git branch --all | grep master && \
    get_report master || \
    echo "${REPO}: no tiene rama master"

  cd /workdir/IslasGECI
done <<< "$REPOS"
