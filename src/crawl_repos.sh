#!/bin/bash
#
# 'crawl_repos' genera los reportes especificados en analyses.json de cada repo.
# La lista de repos la lee de 'data/repos.json'.

function get_report {
      REVISION="$1"
      rm --force analyses.json
      hg revert analyses.json -r "$REVISION"
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
REPOS=$(< ${HOME}/repositorios/reproducibility_inspector/data/repos.json jq --raw-output '.values[].slug')
while read -r REPO; do
  if [ -d "${HOME}/IslasGECI/$REPO" ]; then
    cd ${HOME}/IslasGECI/$REPO
    pwd
    hg pull
  else
    hg clone https://bitbucket.com/IslasGECI/$REPO
    cd ${HOME}/IslasGECI/$REPO
    pwd
  fi
  DEVELOP_NAME=$(hg branches | grep develop | cut -d" " -f1)
  if [ ! -z "$DEVELOP_NAME" ]; then
    echo "Desarrollo: $DEVELOP_NAME"
    get_report "$DEVELOP_NAME"
  else
    echo "Desarrollo: no tiene rama develop"
  fi
  get_report default
cd ${HOME}/IslasGECI
done <<< "$REPOS"
