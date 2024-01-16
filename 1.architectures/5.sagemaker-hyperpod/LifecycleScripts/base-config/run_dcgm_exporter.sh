DCGM_EXPORTER_VERSION=3.3.0-3.2.0


main () {
    docker run -d --rm \
    --gpus all \
    --net host \
    --cap-add SYS_ADMIN \
    nvcr.io/nvidia/k8s/dcgm-exporter:${DCGM_EXPORTER_VERSION}-ubuntu22.04 \
    -f /etc/dcgm-exporter/dcp-metrics-included.csv
}

main