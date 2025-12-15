# frozen_string_literal: true

class Category
  extend AskCollection

  attr_reader :questions

  def initialize(evaluation, category)
    @evaluation = evaluation
    @questions = evaluation.questions_for(category)
  end

  asks :complete?, to: :questions
  asks :conform?, to: :questions
  asks :blank?, to: :questions
end
