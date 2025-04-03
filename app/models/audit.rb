class Audit < ApplicationRecord
  belongs_to :startup,
             class_name: "EspaceMembre::Startup",
             foreign_key: :startup_uuid,
             primary_key: :uuid

  def self.latest
    @latest ||= YAML.safe_load_file("config/standards-beta.yml")
  end
end
