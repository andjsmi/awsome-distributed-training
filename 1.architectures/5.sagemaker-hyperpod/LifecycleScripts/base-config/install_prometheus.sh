#!/bin/bash

set -e

PROMETHEUS_URL="https://github.com/prometheus/prometheus/releases/download/v2.48.1/prometheus-2.48.1.linux-amd64.tar.gz"
PROMETHEUS_DIR="/opt/prometheus"
PROMETHEUS_TARRED="prometheus-2.48.1.linux-amd64"

main() {
    useradd -M -U prometheus
    mkdir -p $PROMETHEUS_DIR
    wget -c $PROMETHEUS_URL -O - | tar -xz --strip-components=1 -C $PROMETHEUS_DIR
    chown prometheus:prometheus -R /opt/prometheus
    cp service-files/prometheus.service /etc/systemd/system
    
    if [[ $1 == "compute" ]]; then
        sed -i "s/INSTANCE_HOSTNAME/$(hostname)/g" prometheus-conf/nvidia.yml
        sed -i "s,PROMETHEUS_URL,$2,g" prometheus-conf/nvidia.yml
        sed -i "s/REGION/$3/g" prometheus-conf/nvidia.yml
        cp prometheus-conf/nvidia.yml $PROMETHEUS_DIR/prometheus.yml
        echo "Using NVIDIA DCGM Prometheus config"
    fi
    if [[ $1 == "controller" ]]; then
        sed -i "s/INSTANCE_HOSTNAME/$(hostname)/g" prometheus-conf/slurm.yml
        sed -i "s,PROMETHEUS_URL,$2,g" prometheus-conf/slurm.yml
        sed -i "s/REGION/$3/g" prometheus-conf/slurm.yml
        cp prometheus-conf/slurm.yml $PROMETHEUS_DIR/prometheus.yml
        echo "Using Slurm Prometheus config"
    fi
    systemctl daemon-reload
    systemctl start prometheus.service
    echo "Installed and started Prometheus"
}

main "$@"