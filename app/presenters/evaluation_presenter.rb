# frozen_string_literal: true

class EvaluationPresenter
  attr_reader :evaluation

  def initialize(evaluation)
    @evaluation = evaluation
  end

  def completion_level(category:)
    questions = evaluation.standards_for(category)

    questions
      .map(&:presented)
      .map(&:completion_level)
      .sum
      .fdiv(questions.size)
  end

  def conformity_level(category:)
    questions = evaluation.standards_for(category)

    questions
      .map(&:presented)
      .map(&:conformity_level)
      .sum
      .fdiv(questions.size)
  end
end
