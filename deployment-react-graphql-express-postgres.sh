#!/bin/bash
echo "Stop Docker..." && \
if $(docker ps | grep -q -i up); then docker stop $(docker ps -q); fi && \
echo "Remove Container..." && \
if $(docker ps -a | grep -q -i Exited); then docker rm -f $(docker ps -a -q); fi && \
echo "Remove Images..." && \
if $(docker images | grep -q -i "\." ); then docker rmi -f $(docker images -q); fi && \

echo "Start Docker Compose ..." && \
docker-compose up -d
