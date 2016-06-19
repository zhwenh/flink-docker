#!/bin/sh

. /start-common.sh

FLINK_MASTER_HOSTNAME="flink-master"
FLINK_MASTER_WEBUI_PORT=8081

echo "$(hostname -i) ${FLINK_MASTER_HOSTNAME}" >> /etc/hosts

${FLINK_BIN_DIR}/jobmanager.sh start cluster ${FLINK_MASTER_HOSTNAME} ${FLINK_MASTER_WEBUI_PORT}
