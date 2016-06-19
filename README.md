# Flink in Docker

This is a Docker image appropriate for running Flink on Kuberenetes. It produces two main images:
* `flink-master` - Runs a Flink master in Standalone mode and exposes a port for Flink and a port for the WebUI.
* `flink-worker` - Runs a Flink worer in Standalone mode and connects to the Flink master via DNS name `flink-master`.

The structure is heavily influenced by https://github.com/kubernetes/application-images/tree/master/spark

# Usage

## Build

Build a docker container with `make`

## Run locally

`docker-compose up` to start with a single TaskManager. `docker-compose scale flink-worker=5` - scale to 5 workers.

## Run in Kubernetes

Use (https://github.com/melentye/flink-kubernetes)[flink-kubernetes]
