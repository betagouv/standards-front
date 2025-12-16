# frozen_string_literal: true

class QuestionPresenter
  attr_reader :question

  def initialize(question)
    @question = question
  end

  def completion_level
    question.criteria.count(&:complete?)
      .fdiv(question.criteria.count)
      .*(100)
  end

  def conformity_level
    question.criteria.count(&:done?)
      .fdiv(question.criteria.count)
      .*(100)
  end
end
