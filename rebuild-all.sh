#!/usr/bin/env bash
docker-compose down clientside-server
docker-compose up clientside-server --build
docker-compose down clientside-server
docker-compose up clientside-server --build
