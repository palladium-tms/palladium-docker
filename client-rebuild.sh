#!/usr/bin/env bash
docker-compose build --no-cache clientside-build
docker-compose up clientside-build
