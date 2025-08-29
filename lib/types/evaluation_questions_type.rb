# frozen_string_literal: true

class EvaluationQuestionsType < ActiveRecord::Type::Json
  def cast(values = [])
    Array(values).map do |value|
      case value
      when Hash
        Evaluation::Question.new(**value.symbolize_keys)
      when Evaluation::Question
        value
      when NilClass
        nil
      end
    end
  end

  def serialize(value)
    ActiveSupport::JSON.encode(value) unless value.nil?
  end

  def deserialize(value)
    data = super

    cast(data)
  end
end
