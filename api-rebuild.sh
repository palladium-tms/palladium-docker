#!/usr/bin/env bash
docker-compose down api-server
docker-compose up api-server --build
