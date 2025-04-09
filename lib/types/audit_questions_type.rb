# frozen_string_literal: true

class AuditQuestionsType < ActiveRecord::Type::Json
  def cast(values = [])
    values.map { |question| Audit::Question.new(**question.symbolize_keys) }
  end

  def serialize(value)
    return nil if value.blank?

    value.map(&:serializable_hash).to_json
  end

  def deserialize(value)
    data = super

    cast(data)
  end

  def ==(other)
    other.is_a?(AddressType)
  end

  # def deserialize(value: [])
  #   # puts "_________> DESERIALIZE"
  #   # value.each { |category| Audit::Category.new(category) }

  # end

  # def cast(value)
  #   return nil unless value.is_a?(String)
  #   return nil unless values.include?(value)

  #   value
  # end
end
