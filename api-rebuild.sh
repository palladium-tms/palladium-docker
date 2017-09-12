#!/usr/bin/env bash
docker-compose build --no-cache api-server
docker-compose down api-server
docker-compose up api-server
