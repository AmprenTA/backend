## Local installation

Steps to follow in order to setup the app locally:

```sh
rvm use ruby-3.1.2@amprenta [--create]
bundle [install]
rails db:create
rails db:migrate
rails db:seed [total_footprints=<IntegerValue>]
rails rails locations:seed
```

## Local testing
- Run the server: `rails s`
- Open the browser and go to:
```sh
http://127.0.0.1:3000
```
- Swagger API:
```sh
http://127.0.0.1:3000/docs
```

## The Docker way
- builds, (re)creates, starts and attaches to containers for a service
```sh
docker-compose up [--build]
```
- list active containers (or all, even inactive ones)
```sh
docker ps [-a]
```

- applies the migrations to the DB
```sh
docker exec <container> rake db:migrate
```

- seeding the DB with the possible flights
```sh
docker exec <container> rake flights:distances_seed
```

- check the Swagger UI
```sh
http://127.0.0.1:3001/docs
```

- stops containers, removes containers, volumes, networks (opposite of up)
```sh
docker-compose down
```

- connecting to a running container and allows interaction 
```sh
docker exec -it <container> bash
```

- removes a container
```sh
docker rm [--force] [--volumes] <container>
```

- removes all unused images without confirmation prompt
```sh
docker system prune -af
```
