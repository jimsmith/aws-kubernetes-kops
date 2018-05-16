#!/bin/bash

export BUILD_CAUSE=${BUILD_CAUSE:='development'}
export BUILD_HOST=$(hostname -s)
export BUILD_USER=$(whoami)

export GIT_AUTHOR="$(git show --format="%an" | head -n 1)"
export GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD | tr '[:upper:]' '[:lower:]')
export GIT_REV="$(git rev-parse --short HEAD)$([[ $(git status --porcelain) != "" ]] && echo "-dirty")"
export GIT_TOP=$(git rev-parse --show-toplevel)

export JENKINS_ID=${BUILD_ID:='NA'}
export JENKINS_URL=${BUILD_URL:='NA'}

export AWS_REGION=${AWS_REGION:='eu-west-1'}

export MINICONDA_VERSION="Miniconda2-latest"

export MINICONDA_PREFIX="${GIT_TOP}/.miniconda"
export MINICONDA_URL="https://repo.continuum.io/miniconda/${MINICONDA_VERSION}-Linux-x86_64.sh"

export PROJECT=aws-kubernetes-my-local-test
export STACK_NAME=${STACK_NAME:="${PROJECT}-${GIT_BRANCH}-${GIT_REV}"}

export PATH=${MINICONDA_PREFIX}/bin:$PATH

exit_code_checker() {
   if [ ${1} -ne 0 ]; then
     echo "ERROR: non-zero exit code returned from"
     echo "ERROR: ${2}"
     exit 1
   fi
 }

 file_exists_checker() {
   if [ ! -e ${1} ]; then
     echo "ERROR: ENOENT ${1}"
     exit 1
   fi
 }
