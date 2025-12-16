class Evaluation < ApplicationRecord
  extend AskCollection

  belongs_to :startup,
             class_name: "EspaceMembre::Startup",
             foreign_key: :startup_uuid,
             primary_key: :uuid

  attribute :questions, :questions

  asks :conform?, to: :questions
  asks :complete?, to: :questions

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

  def standards_for(category)
    questions.select { |question| question.category == category }
  end

  def presented
    EvaluationPresenter.new(self)
  end

  # "N/A" is the defaulted value for all non-versioned standards (pre
  # october 2025) – this version attribute is required not-null.
  def versioned?
    version != "N/A"
  end
end
