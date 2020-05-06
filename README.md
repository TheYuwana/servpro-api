# ServPro API

## Start the docker container in the root
```
docker-compose up
```

## List docker containers
```
docker ps -a
```

## Grab the container ID and enter the container with bas
```
docker exec -it {container id} bash
```

## In the container, Create database and tables
```
mix ecto.setup
```

## In the container, seed the database
```
mix run priv/repo/seeds.exs
```

## And your good to go!
```
http://localhost:4000
```

## Top it off with a client website!
https://github.com/TheYuwana/servpro-web