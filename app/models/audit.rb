class Audit < ApplicationRecord
  belongs_to :startup,
             class_name: "EspaceMembre::Startup",
             foreign_key: :startup_uuid,
             primary_key: :uuid

  attribute :questions, :questions

  def self.latest_standards
    @latest ||= YAML.safe_load_file(ENV.fetch("BETA_STANDARDS_YML_PATH"))
  end

  def initialize_with_latest_standards
    initialize_with(self.class.latest_standards)
  end

  def initialize_with(standards)
    self.tap { |s| s.questions = standards }
  end
end
