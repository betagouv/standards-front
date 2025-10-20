class Evaluation < ApplicationRecord
  belongs_to :startup,
             class_name: "EspaceMembre::Startup",
             foreign_key: :startup_uuid,
             primary_key: :uuid

  attribute :questions, :questions

  class << self
    def latest_standards
      BetaStandards.standards
    end

    def from_latest_standards
      new.initialize_with(latest_standards)
    end
  end

  def initialize_with(standards)
    self.tap do
      self.questions = standards["standards"]
      self.version   = standards["version"]
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

  # "N/A" is the defaulted value for all non-versioned standards (pre
  # october 2025) – this version attribute is required not-null.
  def versioned?
    version != "N/A"
  end
end
