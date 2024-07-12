#!/usr/bin/env bash

az login
az acr login -n assistcloudservices
docker build .
last_image_id=$(docker images | head -2 | tail -n1 | awk '{ $1=""; $2=""; print}'|awk '{print $1}')
docker tag $last_image_id assistcloudservices.azurecr.io/amprenta-be:$1
docker push assistcloudservices.azurecr.io/amprenta-be:$1
