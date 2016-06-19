#!/bin/sh

. /start-common.sh

FLINK_MASTER_HOSTNAME="flink-master"
FLINK_MASTER_WEBUI_PORT=8081

if ! getent hosts ${FLINK_MASTER_HOSTNAME}; then
  echo "=== Cannot resolve the DNS entry for ${FLINK_MASTER_HOSTNAME}. Has the service been created yet, and is SkyDNS functional?"
  echo "=== See http://kubernetes.io/v1.1/docs/admin/dns.html for more details on DNS integration."
  echo "=== Sleeping 10s before pod exit."
  sleep 10
  exit 0
fi

${FLINK_BIN_DIR}/taskmanager.sh start 
