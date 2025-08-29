# frozen_string_literal: true

class Category
  def initialize(evaluation, category)
    @evaluation = evaluation
    @questions = evaluation.questions_for(category)
  end

  def unanswered?
    @questions.all?(&:unanswered?)
  end

  def complete?
    @questions.all?(&:complete?)
  end

  def partially_complete?
    @questions.any?(&:partially_complete?)
  end

  def all_nos?
    @questions.all?(&:all_nos?)
  end
end
