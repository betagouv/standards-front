# frozen_string_literal: true

class AuditQuestionsType < ActiveRecord::Type::Json
  def cast(values = [])
    Array(values).map do |value|
      case value
      when Hash
        Audit::Question.new(**value.symbolize_keys)
      when Audit::Question
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
