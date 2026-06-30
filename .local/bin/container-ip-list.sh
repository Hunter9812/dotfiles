#!/usr/bin/env sh

for ID in $(docker ps -q); do
    IP=$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$ID")
    NAME=$(docker inspect --format='{{.Name}}' "$ID" | sed 's#^/##')

    printf "%s %s\n" "$IP" "$NAME"
done
