#!/usr/bin/env bash
docker-compose down clientside-server
docker-compose build clientside-server
docker-compose up clientside-server
docker-compose down clientside-server
docker-compose build clientside-server
docker-compose up clientside-server
