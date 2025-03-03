#!/bin/bash

for container in dev prod qa; do

  container_id=$(docker ps -qf "name=$container")

  if [[ -n "$container_id" ]]; then
    echo "✅ Container $container is active, starting ssh service..."
    echo "$container_id"
    docker exec "$container_id" service ssh start
  else
    echo "⚠️ Container $container is shutdown, skipping..."
  fi
done