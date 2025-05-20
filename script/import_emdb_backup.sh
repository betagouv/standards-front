#!/bin/bash -e

echo "[auto-audit] Extracting raw backup at: $EMDB_BACKUP_FILE..."
tar xf $EMDB_BACKUP_FILE -O > tmp/latest_backup.pgsql

echo "[auto-audit] Installing PostgreSQL client..."
apt-get install -y postgresql-client

echo "[auto-audit] Running database backup restore..."
pg_restore --verbose --clean --if-exists --no-owner --no-privileges --no-comments --dbname "$ESPACE_MEMBRE_DB_URL" tmp/latest_backup.pgsql

echo "[auto-audit] Done importing."
