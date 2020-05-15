#!/bin/bash

# Let other container still running as long as they have different name
echo "Stop Docker Container ..."
# List of container names to be stopped
Container="web-app api postgres webserver"
for container_name in $Container; do
    if [ "$(docker ps -q -f name=$container_name)" ]; then
        if [ $(docker inspect -f '{{.State.Running}}' $container_name) = "true" ]; then
            echo "Stop Container: "$container_name
            docker stop $container_name
        fi
    fi
done

if [[ $(docker ps -a | grep -i Exited) ]]; then
    echo "Remove Container...";
    docker rm $(docker ps -a | grep -i Exited | grep -Eo '^[^ ]+');
fi
if [[ $(docker images -a | grep -i ago) ]]; then
    echo "Remove Images...";
    docker image prune -af;
fi
if [[ $(docker volume ls -f dangling=true | grep local) ]]; then
    echo "Clean up orphaned volumes"
    docker volume rm $(docker volume ls -qf dangling=true);
fi
if [[ $(docker network ls| grep local) ]]; then
    echo "Clean up orphaned networks";
    docker network prune $(docker network ls -q);
fi

echo "Start Docker Compose ..."
docker-compose up -d

# The database is not ready when the api container starts so the api container has to restart again.
sleep 10;
docker restart api;

Container="web-app api postgres webserver"
for container_name in $Container; do
    if [ "$(docker ps -q -f name=$container_name)" ]; then
        if [ ! $(docker inspect -f '{{.State.Running}}' $container_name) = "true" ]; then
            echo "Container not running: "$container_name
            docker ps -a
            exit
        fi
    fi
done

docker ps -a

echo
echo "** Deployment successful **"
