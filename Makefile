DOCKER-RUN = docker compose run -e TERM --rm --entrypoint=""
BUNDLE-EXEC = bundle exec

ESPACE_MEMBRE_DB = postgresql://postgres:dummy@espace-membre-db:5433
DATABASE_URL     = postgresql://postgres:dummy@primary-db:5434

SCALINGO_EMDB = scalingo --app espace-membre-front --region osc-secnum-fr1
SCALINGO_PROD = scalingo --app standards-prod --region osc-secnum-fr1
SCALINGO_STAG = scalingo --app standards

.PHONY: db

build:
	docker compose build

up:
	docker compose up

watch:
	docker compose up --watch

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
	$(DOCKER-RUN) web $(BUNDLE-EXEC) rdbg -nA web 12345

rs:
	$(DOCKER-RUN) web $(BUNDLE-EXEC) rails r 'Evaluation.delete_all'

# runs a PSQL console to explore the DB
db:
	$(DOCKER-RUN) -e PAGER= primary-db psql $(DATABASE_URL)

# runs a PSQL console to explore the Espace Membre database
emdb:
	$(DOCKER-RUN) -e PAGER= espace-membre-db psql $(ESPACE_MEMBRE_DB)

sc-prod:
	$(SCALINGO_PROD) run bin/rails c

sc:
	$(SCALINGO_STAG) run bin/rails c

import-emdb-backup:
	$(SCALINGO_EMDB) --addon postgresql backups-download --output tmp/latest_backup.tar.gz
	$(DOCKER-RUN) -e EMDB_BACKUP_FILE=tmp/latest_backup.tar.gz web bash script/import_emdb_backup.sh
