# README

## Docker

To mount the project

inside the main foler:

```
docker-compose up --build
```

To connect to the rails console

```
docker-compose exec app rails c
```

Run the server

```
docker-compose exec app rails server -b 0.0.0.0
```
