# frozen_string_literal: true

class EvaluationPresenter
  attr_reader :evaluation

  def initialize(evaluation)
    @evaluation = evaluation
  end

  def completion_level
    all_questions = evaluation.questions

    all_questions
      .map(&:presented)
      .map(&:completion_level)
      .sum
      .fdiv(all_questions.size)
      .round(2)
  end

  def conformity_level(category:)
    questions = evaluation.standards_for(category)

    questions
      .map(&:presented)
      .map(&:conformity_level)
      .sum
      .fdiv(questions.size)
  end

  def completion_stats
    stats_for(:completion)
  end

  def conformity_stats
    stats_for(:conformity)
  end

  private

  def stats_for(type)
    evaluation.categories.map do |category|
      standards = evaluation.standards_for(category)

      [
        category,
        standards
          .map { |standard| standard.presented.send("#{type}_level") }
          .sum
          .fdiv(standards.count)
      ]
    end.to_h
  end
end
