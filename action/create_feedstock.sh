#!/bin/bash

META_PATH=$1
RECIPES_DIR=$(dirname "/github/workspace/$META_PATH")

create_feedstock () {
  if gh api "repos/pangeo-forge/$REPO_NAME" --silent
  then
    echo "pangeo-forge/$REPO_NAME already exists, your id in meta.yaml should be unique"
    exit 1
  fi

  git init "/$REPO_NAME" && cd "/$REPO_NAME" || exit

  gh repo create "pangeo-forge/$REPO_NAME" -d "The $FEEDSTOCK_NAME Feedstock" --template pangeo-forge/feedstock-template --public --confirm

  echo "$RECIPES_DIR"

  ls "$RECIPES_DIR"

  # git remote -v

  # git branch -a

  # git fetch --all

  # git pull origin main

  # git checkout main

  # git remote set-url origin "https://pangeo-forge:$GITHUB_TOKEN@github.com/pangeo-forge/$REPO_NAME.git"

  mkdir feedstock

  cp -r "$RECIPES_DIR" feedstock/

  cat <<EOF > ./README.md
  # $REPO_NAME
  This repository has been generated via the [\`feedstock-creation-action\`](https://github.com/pangeo-forge/feedstock-creation-action) for the $FEEDSTOCK_NAME Feedstock

EOF

  git config --global user.email "you@example.com"
  git config --global user.name "cisaacstern"

  git add -A

  git commit -m "Add Feedstock files"

  git push origin main
}

while IFS= read -r value; do
    FEEDSTOCK_NAME="$value"
    REPO_NAME=$FEEDSTOCK_NAME-feedstock
    create_feedstock
done < <(yq eval '.recipes[].id' /github/workspace/"$META_PATH")
