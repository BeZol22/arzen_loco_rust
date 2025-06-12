## Devcontainer not working, BUT!


## How is postgreSQL currently running inside docker:
docker run -d -p 5432:5432 \
  -e POSTGRES_USER=loco \
  -e POSTGRES_DB=arzen_loco_rust_development \
  -e POSTGRES_PASSWORD="loco" \
  postgres:15.3-alpine

## To list containers
docker ps

## Backup:
docker exec <container_name_or_id> pg_dump -U loco arzen_loco_rust_development > backup.sql

## Restore:
docker exec -i <container_name_or_id> psql -U loco arzen_loco_rust_development < backup.sql


## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## 


docker compose up -d

## To make a backup (=dump) from the database:

0. If container not running: docker compose up

1. Inside .devcontainer directory run the command: docker compose exec db pg_dump -U loco arzen_loco_rust_development > backup.sql



## To restore database from backup:

0. If container not running: docker compose up

1. docker compose exec db psql -U loco arzen_loco_rust_development < backup.sql