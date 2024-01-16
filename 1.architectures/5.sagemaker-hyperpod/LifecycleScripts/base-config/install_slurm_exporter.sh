#!/bin/bash


set -e

export VERSION=1.21.5 OS=linux ARCH=amd64



main() {
    wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz
    tar -xzvf go$VERSION.$OS-$ARCH.tar.gz
    export PATH=$PWD/go/bin:$PATH

    # clone the source code
    git clone https://github.com/vpenso/prometheus-slurm-exporter.git /opt/prometheus-slurm-exporter
    cp service-files/prometheus-slurm-exporter.service /etc/systemd/system/
    cd /opt/prometheus-slurm-exporter && \
    make

    systemctl daemon-reload
    systemctl start prometheus-slurm-exporter.service

    echo "Started Prometheus Slurm Exporter"
}

main