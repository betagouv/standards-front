DOCKER-RUN = docker compose run -e TERM --rm --entrypoint=""
BUNDLE-EXEC = bundle exec

ESPACE_MEMBRE_DB = postgresql://postgres:dummy@espace-membre-db:5433

.PHONY: %
build:
	docker compose build

up:
	docker compose up

down:
	docker compose down

die:
	docker compose down --remove-orphans --volumes

sh:
	$(DOCKER-RUN) web bash

cl:
	$(DOCKER-RUN) web bin/rails c

lint:
	$(DOCKER-RUN) web $(BUNDLE-EXEC) rubocop

guard:
	$(DOCKER-RUN) web $(BUNDLE-EXEC) guard

debug:
	$(DOCKER-RUN) web $(BUNDLE-EXEC) rdbg -A web 12345

# runs a PSQL console to explore the Espace Membre database
emdb:
	$(DOCKER-RUN) -e PAGER= -e PGPASSWORD=dummy espace-membre-db psql $(ESPACE_MEMBRE_DB)
