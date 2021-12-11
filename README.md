# palladium-docker

## Usage

use "docker-compose up" in directory of project for start services

There are 4 containers:
  
* `db`: container with database for api-server
* `api-server`: container with api server.
  It use puma socket for connect with master container
* `clientside-build`: container for building client side.
  It build and put files to shared folder in './dist'.
  It will dead after building.
* `nginx-server`: master container. It take puma socket from api-server
  and it will be available in [http://host/api](http://host/api)
  path, and take client side folder.
  It will be available in [http://host/api](http://host/api) path.

## Update

For update container with server api:
```docker-compose up -d --no-deps --build api-server```

For update view side
```docker-compose up -d --no-deps --build clientside-build```
