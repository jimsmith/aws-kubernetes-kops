#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f $0))
. ${SCRIPT_DIR}/common.sh


# Download Installer
curl -s -o ${GIT_TOP}/${MINICONDA_VERSION}.sh ${MINICONDA_URL}

if [ -d ${MINICONDA_PREFIX} ]; then
  rm -rf ${MINICONDA_PREFIX}
fi

# Install
if [ -e ${GIT_TOP}/${MINICONDA_VERSION}.sh ]; then
  bash ${GIT_TOP}/${MINICONDA_VERSION}.sh -b -p ${MINICONDA_PREFIX}

  if [ $? -ne 0 ]; then
    echo "ERROR: Unable to install ${MINICONDA_VERSION}"
    exit 4
  fi

rm ${GIT_TOP}/${MINICONDA_VERSION}.sh
else
  echo "ERROR: Unable to locate ${GIT_TOP}/{$MINICONDA_VERSION}.sh"
  exit 1
fi

# Update Conda to latest version
if [ -e ${MINICONDA_PREFIX}/bin/conda ] ; then
  ${MINICONDA_PREFIX}/bin/conda update -n base conda

 # Create isolated environment
 ${MINICONDA_PREFIX}/bin/conda create --yes --quiet --name "${PROJECT}" python=2.7 pip
fi
