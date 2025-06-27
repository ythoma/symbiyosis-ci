FROM ubuntu:22.04
ARG USERID=500
ARG GROUPID=${USERID}
ENV USERNAME=cern
ENV GROUPNAME=${USERNAME}
ENV USERHOME=/home/${USERNAME}/
ENV WORKDIR=${USERHOME}/formal_verif

# Install base
RUN apt update && \
apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt install -y git python3-full build-essential perl rsync file wget cpio unzip bc

# Setup environment
RUN echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    addgroup --gid ${GROUPID} ${GROUPNAME} && \
    adduser --disabled-password --shell /bin/bash --uid ${USERID} --ingroup ${GROUPNAME} --home ${USERHOME} ${USERNAME} && \
    adduser ${USERNAME} sudo && \
    mkdir ${WORKDIR} && \
    chown ${USERNAME}:${GROUPNAME} -R ${WORKDIR}

WORKDIR ${WORKDIR}

# Install OSS CAD Suite
RUN wget https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2025-06-27/oss-cad-suite-linux-x64-20250627.tgz &&\
tar -xzf oss-cad-suite-linux-x64-20250627.tgz -C /opt/ &&\
rm -rf oss-cad-suite-linux-x64-20250627.tgz

ENV VIRTUAL_ENV=/opt/oss_cad_suite
ENV VIRTUAL_ENV_PROMPT='OSS CAD Suite'
ENV PATH="/opt/oss-cad-suite/bin:/opt/oss-cad-suite/py3bin:$PATH"
ENV VERILATOR_ROOT="/opt/oss-cad-suite/share/verilator"
ENV GHDL_PREFIX="/opt/oss-cad-suite/lib/ghdl"

