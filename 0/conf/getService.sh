#!/bin/bash
SERVICE_NAME=$(curl http://rancher-metadata/latest/self/service/name)
export SERVICE_NAME