#!/bin/bash
REPOS="backend:app"
DEST_DIR=/srv/
SUBDIR=/releases/devenv
REPO_URL=git@github.com:reciperi

# Install git
stat /usr/bin/git > /dev/null || sudo apt-get install git

# Install github keys
grep github ~/.ssh/known_hosts || ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# Create repos inside
for i in ${REPOS}; do
    DIR_NAME=$(echo "$i"| cut -d: -f 2)
    REPO=${REPO_URL}/$(echo "$i"| cut -d: -f 1).git
    DIR=${DEST_DIR}/${DIR_NAME}/${SUBDIR}
    BASE_DIR=${DEST_DIR}/${DIR_NAME}
    sudo mkdir -p ${BASE_DIR} && sudo chown vagrant ${BASE_DIR}
    [ -d "$DIR" ] || /usr/bin/git clone "$REPO" "$DIR"
done
