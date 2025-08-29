class Evaluation < ApplicationRecord
  belongs_to :startup,
             class_name: "EspaceMembre::Startup",
             foreign_key: :startup_uuid,
             primary_key: :uuid

  attribute :questions, :questions

  def self.latest_standards
    @latest ||= BetaStandards.standards
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
    questions
      .group_by(&:category)
      .sort_by { |k, v| I18n.transliterate(k).to_s }
      .to_h
  end

  def questions_for(category)
    grouped_questions[category]
  end

  # FIXME: cleanup all of these
  def total_completion
    ((questions.count(&:answered?).to_f / questions.count) * 100).round(0)
  end

  def completion_stats
    grouped_questions.map do |category, questions|
      [ category, (questions.count(&:complete?).to_f / questions.count * 100).round(2) ]
    end.to_h
  end

  def complete?
    questions.all?(&:complete?)
  end

  def next_question_after(question)
    others = questions_for(question.category) - [ question ]

    others.find(&:unanswered?)
  end

  private

  def selected_categories
    ENV.fetch("BETA_STANDARDS_SELECTED_CATEGORIES", "").split(",")
  end
end
