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
    self.tap do |a|
      a.questions =
        if selected_categories.any?
          standards.filter { |q| q["category"].in?(selected_categories) }
        else
          standards
        end
    end
  end

  def grouped_questions
    questions.group_by(&:category)
  end

  def questions_for(category)
    grouped_questions[category]
  end

  def total_completion
    questions.count / questions.count(&:complete?)
  end

  def completion_stats
    grouped_questions.map do |category, questions|
      [ category, (questions.count(&:complete?).to_f / questions.count * 100).round(2) ]
    end.to_h
  end

  private

  def selected_categories
    ENV.fetch("BETA_STANDARDS_SELECTED_CATEGORIES").split(",")
  end
end
