#!/bin/bash
# Usage: start_tb INSTANCE_NAME INTERNAL_IP PORT
INSTANCE_NAME=$1
INSTANCE_IP=$2
PORT=$3
gcloud compute ssh --ssh-flag="-N" --ssh-flag="-L" --ssh-flag="localhost:8080:$INSTANCE_IP:$PORT" ${USER}@${INSTANCE_NAME}

