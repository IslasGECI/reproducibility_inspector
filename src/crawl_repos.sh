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

cd ${HOME}/IslasGECI
pwd
REPOS=$(< ${HOME}/repositorios/reproducibility_inspector/data/repos.json jq --raw-output '.values[] | select(.scm == "git").slug')
while read -r REPO; do
  if [ -d "${HOME}/IslasGECI/$REPO" ]; then
    cd ${HOME}/IslasGECI/$REPO
    pwd
    git fetch
  else
    git clone git@bitbucket.org:IslasGECI/${REPO}.git
    cd ${HOME}/IslasGECI/$REPO
    pwd
  fi

  git branch --all | grep develop && \
    get_report develop || \
    echo "${REPO}: no tiene rama develop"

 git branch --all | grep master && \
    get_report master || \
    echo "${REPO}: no tiene rama master"

  cd ${HOME}/IslasGECI
done <<< "$REPOS"
