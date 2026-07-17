# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 0) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pg_stat_statements"
  enable_extension "uuid-ossp"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "missions_status_enum", ["independent", "admin", "service"]
  create_enum "users_domaine_enum", ["Animation", "Coaching", "Déploiement", "Design", "Développement", "Intraprenariat", "Produit", "Autre", "Data", "Support", "Attributaire"]

  create_table "accounts", id: :serial, force: :cascade do |t|
    t.text "access_token"
    t.bigint "expires_at"
    t.text "id_token"
    t.string "provider", limit: 255, null: false
    t.string "providerAccountId", limit: 255, null: false
    t.text "refresh_token"
    t.text "scope"
    t.text "session_state"
    t.text "token_type"
    t.string "type", limit: 255, null: false
    t.string "userId", limit: 255, null: false
  end

  create_table "badge_requests", id: :serial, force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "dossier_number"
    t.string "ds_token", limit: 255
    t.timestamptz "end_date", null: false
    t.text "request_id", null: false
    t.timestamptz "start_date", null: false
    t.text "status"
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.text "username", null: false
  end

  create_table "community", id: false, force: :cascade do |t|
    t.integer "admin"
    t.integer "animation"
    t.integer "autre"
    t.integer "coaching"
    t.date "date"
    t.integer "deploiement"
    t.integer "design"
    t.integer "developpement"
    t.integer "female"
    t.integer "independent"
    t.integer "intraprenariat"
    t.integer "male"
    t.integer "nsp"
    t.integer "other"
    t.integer "produit"
    t.integer "service"
  end

  create_table "dinum_emails", primary_key: "uuid", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "destination", limit: 255
    t.string "email", limit: 255, null: false
    t.string "status", limit: 255
    t.string "type", limit: 255
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.uuid "user_id"

    t.unique_constraint ["email"], name: "dinum_emails_email_unique"
  end

  create_table "events", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.text "action_code", null: false
    t.hstore "action_metadata"
    t.uuid "action_on_startup"
    t.text "action_on_username"
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.text "created_by_username", null: false
  end

  create_table "formations", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "airtable_id", limit: 255
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamptz "formation_date", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "formation_type", limit: 255
    t.string "formation_type_airtable_id", limit: 255
    t.boolean "is_embarquement"
    t.text "name", null: false
    t.integer "nb_active_members"
    t.integer "nb_total_members"

    t.unique_constraint ["airtable_id"], name: "formations_airtable_id_unique"
  end

  create_table "incubators", primary_key: "uuid", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "address", limit: 255
    t.string "contact", limit: 255
    t.text "description"
    t.string "ghid", limit: 255
    t.text "github"
    t.uuid "highlighted_startups", array: true
    t.uuid "owner_id"
    t.text "short_description"
    t.string "title", limit: 255, null: false
    t.text "website"

    t.unique_constraint ["ghid"], name: "incubators_ghid_unique"
  end

  create_table "knex_migrations", id: :serial, force: :cascade do |t|
    t.integer "batch"
    t.timestamptz "migration_time"
    t.string "name", limit: 255
  end

  create_table "knex_migrations_lock", primary_key: "index", id: :serial, force: :cascade do |t|
    t.integer "is_locked"
  end

  create_table "marrainage", primary_key: "username", id: :text, force: :cascade do |t|
    t.boolean "completed", default: false, null: false
    t.integer "count", default: 1, null: false
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.text "last_onboarder", null: false
    t.timestamptz "last_updated", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "marrainage_groups", id: :serial, force: :cascade do |t|
    t.integer "count", default: 0, null: false
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }
    t.string "onboarder", limit: 255
    t.string "status", limit: 255, default: "PENDING"
  end

  create_table "marrainage_groups_members", primary_key: ["marrainage_group_id", "username"], force: :cascade do |t|
    t.bigint "marrainage_group_id", null: false
    t.string "username", limit: 255, null: false
    t.index ["marrainage_group_id"], name: "marrainage_groups_members_marrainage_group_id_index"
    t.index ["username"], name: "marrainage_groups_members_username_index"
  end

  create_table "matomo_sites", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "matomo_id", null: false
    t.string "name", limit: 255, null: false
    t.uuid "startup_id"
    t.string "type", limit: 255, null: false
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.text "url"

    t.unique_constraint ["matomo_id"], name: "matomo_sites_matomo_id_unique"
  end

  create_table "mattermost_member_infos", id: false, force: :cascade do |t|
    t.date "last_activity_at"
    t.text "mattermost_user_id"
    t.text "username", default: "primary"
  end

  create_table "missions", primary_key: "uuid", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "employer", limit: 255
    t.date "end"
    t.serial "id", null: false
    t.date "start", null: false
    t.enum "status", enum_type: "missions_status_enum"
    t.uuid "user_id"
    t.index ["user_id"], name: "missions_user_id_idx"
    t.check_constraint "start < \"end\"", name: "missions_dates_check"
  end

  create_table "missions_startups", primary_key: "uuid", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "mission_id", null: false
    t.uuid "startup_id", null: false
    t.index ["mission_id"], name: "missions_startups_mission_id_idx"
    t.index ["startup_id"], name: "missions_startups_startup_id_idx"
    t.unique_constraint ["startup_id", "mission_id"], name: "missions_startups_startup_id_mission_id_unique"
  end

  create_table "newsletters", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.text "brevo_url"
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamptz "publish_at"
    t.timestamptz "sent_at"
    t.text "url", null: false
    t.text "validator"
    t.string "year_week", limit: 255
  end

  create_table "organizations", primary_key: "uuid", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "acronym", limit: 255
    t.string "domaine_ministeriel", limit: 255, null: false
    t.string "ghid", limit: 255
    t.string "name", limit: 255, null: false
    t.string "type", limit: 255, null: false

    t.unique_constraint ["acronym"], name: "organizations_acronym_unique"
    t.unique_constraint ["ghid"], name: "organizations_ghid_unique"
    t.unique_constraint ["name"], name: "organizations_name_unique"
  end

  create_table "phases", primary_key: "uuid", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.text "comment"
    t.timestamptz "end"
    t.text "name", null: false
    t.timestamptz "start", null: false
    t.uuid "startup_id", null: false

    t.check_constraint "name = ANY (ARRAY['investigation'::text, 'construction'::text, 'acceleration'::text, 'perennisation'::text, 'transfer'::text, 'success'::text, 'alumni'::text, 'abandon'::text, 'abandon-investigation'::text, 'transfere'::text, 'opere'::text])", name: "chk_phase_name"
    t.check_constraint "start < \"end\"", name: "startups_phase_check"
    t.unique_constraint ["startup_id", "name"], name: "phases_startup_id_name_unique"
  end

  create_table "sentry_teams", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "name", limit: 255, null: false
    t.string "sentry_id", limit: 255, null: false
    t.string "slug", limit: 255
    t.uuid "startup_id"
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false

    t.unique_constraint ["sentry_id"], name: "sentry_teams_sentry_id_unique"
    t.unique_constraint ["slug"], name: "sentry_teams_slug_unique"
  end

  create_table "service_accounts", primary_key: "uuid", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "account_type", limit: 255, null: false
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "email", limit: 255
    t.jsonb "metadata"
    t.string "service_user_id", limit: 255
    t.string "status", limit: 255
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.uuid "user_id"

    t.unique_constraint ["account_type", "service_user_id", "email"], name: "service_accounts_account_type_service_user_id_email_unique"
  end

  create_table "sessions", id: :serial, force: :cascade do |t|
    t.timestamptz "expires", null: false
    t.string "sessionToken", limit: 255, null: false
    t.string "userId", limit: 255, null: false
  end

  create_table "startup_aggregated_stats", id: false, force: :cascade do |t|
    t.decimal "active_member_change_from_last_month", precision: 8, scale: 2
    t.decimal "active_member_current", precision: 8, scale: 2
    t.decimal "active_member_one_month_ago", precision: 8, scale: 2
    t.decimal "active_member_three_months_ago", precision: 8, scale: 2
    t.decimal "active_member_trend_over_six_months", precision: 8, scale: 2
    t.decimal "active_member_trend_over_three_months", precision: 8, scale: 2
    t.decimal "active_member_trend_over_twelve_months", precision: 8, scale: 2
    t.decimal "active_member_two_months_ago", precision: 8, scale: 2
    t.decimal "average_mission_duration_value", precision: 8, scale: 2
    t.decimal "average_replacement_frequency_value", precision: 8, scale: 2
    t.decimal "bizdev_change_from_last_month", precision: 8, scale: 2
    t.decimal "bizdev_current", precision: 8, scale: 2
    t.decimal "bizdev_one_month_ago", precision: 8, scale: 2
    t.decimal "bizdev_three_months_ago", precision: 8, scale: 2
    t.decimal "bizdev_trend_over_six_months", precision: 8, scale: 2
    t.decimal "bizdev_trend_over_three_months", precision: 8, scale: 2
    t.decimal "bizdev_trend_over_twelve_months", precision: 8, scale: 2
    t.decimal "bizdev_two_months_ago", precision: 8, scale: 2
    t.string "current_phase", limit: 255
    t.date "current_phase_start_date"
    t.decimal "dev_change_from_last_month", precision: 8, scale: 2
    t.decimal "dev_current", precision: 8, scale: 2
    t.decimal "dev_one_month_ago", precision: 8, scale: 2
    t.decimal "dev_three_months_ago", precision: 8, scale: 2
    t.decimal "dev_trend_over_six_months", precision: 8, scale: 2
    t.decimal "dev_trend_over_three_months", precision: 8, scale: 2
    t.decimal "dev_trend_over_twelve_months", precision: 8, scale: 2
    t.decimal "dev_two_months_ago", precision: 8, scale: 2
    t.boolean "had_coach"
    t.boolean "had_intra"
    t.boolean "has_coach"
    t.boolean "has_intra"
    t.decimal "renewal_rate_value", precision: 8, scale: 2
    t.decimal "turnover_rate_value", precision: 8, scale: 2
    t.uuid "uuid", null: false
  end

  create_table "startup_events", primary_key: "uuid", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.text "comment"
    t.date "date", null: false
    t.string "name", limit: 255, null: false
    t.uuid "startup_id"
  end

  create_table "startups", primary_key: "uuid", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "accessibility_status", limit: 255
    t.boolean "analyse_risques"
    t.text "analyse_risques_url"
    t.text "budget_url"
    t.text "contact"
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.text "dashlord_url"
    t.text "description"
    t.string "dsfr_status", limit: 255
    t.string "ecodesign_url", limit: 255
    t.string "ghid", limit: 255, null: false
    t.boolean "has_mobile_app", default: false
    t.string "impact_url", limit: 255
    t.uuid "incubator_id"
    t.boolean "is_private_url", default: false
    t.text "link"
    t.string "mailing_list", limit: 255
    t.boolean "mon_service_securise"
    t.string "name", limit: 255, null: false
    t.text "pitch"
    t.text "repository"
    t.string "roadmap_url", limit: 255
    t.boolean "stats"
    t.text "stats_url"
    t.string "tech_audit_url", limit: 255
    t.jsonb "techno"
    t.jsonb "thematiques"
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.jsonb "usertypes"

    t.unique_constraint ["ghid"], name: "startups_id_unique"
  end

  create_table "startups_files", primary_key: "uuid", id: :text, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.binary "base64"
    t.text "comments"
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.uuid "created_by", null: false
    t.jsonb "data"
    t.timestamptz "deleted_at"
    t.uuid "deleted_by"
    t.text "filename"
    t.integer "size"
    t.uuid "startup_id", null: false
    t.text "title"
    t.text "type"
  end

  create_table "startups_organizations", primary_key: "uuid", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "organization_id", null: false
    t.uuid "startup_id", null: false

    t.unique_constraint ["startup_id", "organization_id"], name: "startups_organizations_startup_id_organization_id_unique"
  end

  create_table "tasks", primary_key: "name", id: :text, force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.text "description"
    t.text "error_message"
    t.timestamptz "last_completed"
    t.timestamptz "last_failed"
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "teams", primary_key: "uuid", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "ghid", limit: 255
    t.uuid "incubator_id", null: false
    t.text "mission"
    t.string "name", limit: 255, null: false
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false

    t.unique_constraint ["ghid"], name: "teams_ghid_unique"
  end

  create_table "user_events", primary_key: "uuid", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.timestamptz "date", null: false
    t.string "field_id", limit: 255, null: false
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.uuid "user_id", null: false

    t.unique_constraint ["field_id", "user_id"], name: "user_events_field_id_user_id_unique"
  end

  create_table "users", primary_key: "username", id: :text, force: :cascade do |t|
    t.text "avatar"
    t.float "average_nb_of_days", limit: 24
    t.text "bio"
    t.string "communication_email", limit: 255, default: "primary"
    t.jsonb "competences"
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.enum "domaine", null: false, enum_type: "users_domaine_enum"
    t.boolean "email_is_redirection", default: false
    t.timestamptz "email_verified"
    t.string "fullname", limit: 255, null: false
    t.text "gender", default: "NSP"
    t.string "github", limit: 255
    t.string "legal_status", limit: 255
    t.text "link"
    t.string "member_type", limit: 255
    t.text "osm_city"
    t.text "primary_email"
    t.string "primary_email_status", limit: 255, default: "EMAIL_UNSET"
    t.timestamptz "primary_email_status_updated_at", default: -> { "CURRENT_TIMESTAMP" }
    t.string "role", limit: 255, null: false
    t.text "secondary_email"
    t.integer "tjm"
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
    t.text "workplace_insee_code"

    t.unique_constraint ["uuid"], name: "users_uuid_unique"
  end

  create_table "users2", id: false, force: :cascade do |t|
    t.text "avatar"
    t.float "average_nb_of_days", limit: 24
    t.text "bio"
    t.string "communication_email", limit: 255
    t.jsonb "competences"
    t.timestamptz "created_at"
    t.enum "domaine", enum_type: "users_domaine_enum"
    t.boolean "email_is_redirection"
    t.timestamptz "email_verified"
    t.string "fullname", limit: 255
    t.text "gender"
    t.string "github", limit: 255
    t.string "legal_status", limit: 255
    t.text "link"
    t.string "member_type", limit: 255
    t.text "osm_city"
    t.text "primary_email"
    t.string "primary_email_status", limit: 255
    t.timestamptz "primary_email_status_updated_at"
    t.string "role", limit: 255
    t.text "secondary_email"
    t.integer "tjm"
    t.timestamptz "updated_at"
    t.text "username"
    t.uuid "uuid"
    t.text "workplace_insee_code"
  end

  create_table "users_formations", id: false, force: :cascade do |t|
    t.uuid "formation_id"
    t.text "username"
    t.index ["formation_id"], name: "users_formations_formation_id_index"
    t.index ["username"], name: "users_formations_username_index"
  end

  create_table "users_teams", primary_key: "uuid", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "team_id", null: false
    t.uuid "user_id", null: false

    t.unique_constraint ["user_id", "team_id"], name: "users_teams_user_id_team_id_unique"
  end

  create_table "verification_tokens", primary_key: ["identifier", "token"], force: :cascade do |t|
    t.timestamptz "expires", null: false
    t.text "identifier", null: false
    t.text "token", null: false
  end

  add_foreign_key "events", "startups", column: "action_on_startup", primary_key: "uuid", name: "events_action_on_startup_foreign"
  add_foreign_key "incubators", "organizations", column: "owner_id", primary_key: "uuid", name: "incubators_owner_id_foreign"
  add_foreign_key "marrainage_groups_members", "marrainage_groups", name: "marrainage_groups_members_marrainage_group_id_foreign"
  add_foreign_key "marrainage_groups_members", "users", column: "username", primary_key: "username", name: "marrainage_groups_members_username_foreign"
  add_foreign_key "matomo_sites", "startups", primary_key: "uuid", name: "matomo_sites_startup_id_foreign", on_delete: :cascade
  add_foreign_key "missions", "users", primary_key: "uuid", name: "missions_user_id_foreign", on_update: :cascade, on_delete: :cascade
  add_foreign_key "missions_startups", "missions", primary_key: "uuid", name: "missions_startups_mission_id_foreign", on_delete: :cascade
  add_foreign_key "missions_startups", "startups", primary_key: "uuid", name: "missions_startups_startup_id_foreign", on_delete: :cascade
  add_foreign_key "phases", "startups", primary_key: "uuid", name: "phases_startup_id_foreign", on_delete: :cascade
  add_foreign_key "sentry_teams", "startups", primary_key: "uuid", name: "sentry_teams_startup_id_foreign", on_delete: :cascade
  add_foreign_key "service_accounts", "users", primary_key: "uuid", name: "service_accounts_user_id_foreign", on_delete: :cascade
  add_foreign_key "startup_aggregated_stats", "startups", column: "uuid", primary_key: "uuid", name: "startup_aggregated_stats_uuid_foreign", on_delete: :cascade
  add_foreign_key "startup_events", "startups", primary_key: "uuid", name: "startup_events_startup_id_foreign"
  add_foreign_key "startups", "incubators", primary_key: "uuid", name: "startups_incubator_id_foreign"
  add_foreign_key "startups_files", "startups", primary_key: "uuid", name: "startups_files_startup_id_foreign", on_delete: :cascade
  add_foreign_key "startups_organizations", "organizations", primary_key: "uuid", name: "startups_organizations_organization_id_foreign", on_delete: :cascade
  add_foreign_key "startups_organizations", "startups", primary_key: "uuid", name: "startups_organizations_startup_id_foreign", on_delete: :cascade
  add_foreign_key "teams", "incubators", primary_key: "uuid", name: "teams_incubator_id_foreign", on_delete: :cascade
  add_foreign_key "user_events", "users", primary_key: "uuid", name: "user_events_user_id_foreign", on_delete: :cascade
  add_foreign_key "users_formations", "formations", name: "users_formations_formation_id_foreign"
  add_foreign_key "users_formations", "users", column: "username", primary_key: "username", name: "users_formations_username_foreign"
  add_foreign_key "users_teams", "teams", primary_key: "uuid", name: "users_teams_team_id_foreign", on_delete: :cascade
  add_foreign_key "users_teams", "users", primary_key: "uuid", name: "users_teams_user_id_foreign", on_delete: :cascade
end
