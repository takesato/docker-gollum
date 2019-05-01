#!/bin/sh

echo ${REPO_URL}
if [ "x" != "x${REPO_URL}" ]; then
  echo 'setting git repository'
  cd ${GOLLUM_HOME}
  git remote -v | grep ${REPO_URL}
  if [ $? -eq 1 ]; then
    echo "Add origin url ${REPO_URL}"
    git config user.email "${GIT_EMAIL}"
    git config user.name "${GIT_NAME}"
    git config http.cookiefile "/root/.gitcookies"
    git remote add origin ${REPO_URL}
    git fetch
    git checkout master
  fi
fi

cd ${0%/*}
exec bundle exec $@
