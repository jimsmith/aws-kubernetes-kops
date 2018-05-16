#!/bin/bash

# We must source this file - https://askubuntu.com/a/965496

# SCRIPT_DIR=$(dirname $(readlink -f $0))
. ./build/common.sh

ACTIVATE="activate"
DEACTIVATE="deactivate"

# Provision & Configure Conda
make -C ./


# Activate conda environment itself, then install PIP packages (miniconda wide not environment specific)
echo -e
echo -e "Activating this environment"
. ${MINICONDA_PREFIX}/bin/activate ${PROJECT} && pip install --upgrade pip && pip install -r "${GIT_TOP}/requirements.txt"
echo -e

# Enable tab completion
conda install argcomplete

# Activate conda environment script
cat <<EOF > ./${ACTIVATE}.sh
. ${MINICONDA_PREFIX}/bin/activate ${PROJECT}
EOF
chmod 755 ./${ACTIVATE}.sh


# Deactivate conda environment script
cat <<EOF > ./${DEACTIVATE}.sh
. ${MINICONDA_PREFIX}/bin/deactivate
EOF
chmod 755 ./${DEACTIVATE}.sh


# kops - Kubernetes Operations software

# kubectl is required
echo -e
echo -e "-------------------"
echo -e "Downloading kubectl"
echo -e "-------------------"
STABLE_VERSION=v1.10.0
curl --ipv4 -o ${CONDA_PREFIX}/bin/kubectl -L https://storage.googleapis.com/kubernetes-release/release/${STABLE_VERSION}/bin/linux/amd64/kubectl \
&& chmod 755 ${CONDA_PREFIX}/bin/kubectl \
&& echo -e && kubectl version

# kops is required
echo -e
echo -e "--------------------"
echo -e "Downloading kops cli"
echo -e "--------------------"
#LATEST_VERSION=1.8.1
# 12/04/2018 1.9.0
LATEST_VERSION=1.9.0
curl --ipv4 -L -o ${CONDA_PREFIX}/bin/kops https://github.com/kubernetes/kops/releases/download/{$LATEST_VERSION}/kops-linux-amd64 \
&& chmod 755 ${CONDA_PREFIX}/bin/kops \
&& echo -e && kops version

NON_LATEST_VERSION=1.9.0-beta.1
curl --ipv4 -L -o ${CONDA_PREFIX}/bin/kops-${NON_LATEST_VERSION} https://github.com/kubernetes/kops/releases/download/{$NON_LATEST_VERSION}/kops-linux-amd64 \
&& chmod 755 ${CONDA_PREFIX}/bin/kops-${NON_LATEST_VERSION} \
&& echo -e && kops-${NON_LATEST_VERSION} version

# kubectx is required
echo -e
echo -e "-----------------------"
echo -e "Downloading kubectx cli"
echo -e "-----------------------"
wget -q https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx -O ${CONDA_PREFIX}/bin/kubectx \
&& chmod 755 ${CONDA_PREFIX}/bin/kubectx
wget -q https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens -O ${CONDA_PREFIX}/bin/kubens \
&& chmod 755 ${CONDA_PREFIX}/bin/kubens
wget -q https://raw.githubusercontent.com/ahmetb/kubectx/master/completion/kubectx.bash -O ${CONDA_PREFIX}/bin/kubectx.bash

# kube-ps1 is required
wget -q https://raw.githubusercontent.com/jonmosco/kube-ps1/master/kube-ps1.sh -O ${CONDA_PREFIX}/bin/kube-ps1.sh \
&& chmod 755 ${CONDA_PREFIX}/bin/kube-ps1.sh
