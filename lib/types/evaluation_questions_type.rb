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

  # FIXME: this is annoying; it tells ActiveRecord to save an
  # evaluation's questions when they've changed, because the model
  # itself (Evaluation::Question) overrides the equality operator and
  # says:
  #
  # "I'm the same if I've got the same slug (= id) than the other".
  #
  # which is really useful for the evaluation upgrade code since it
  # allows diffing the changes with simple array substractions (see
  # evaluation_upgrader.rb). The annoying side-effect is that
  # answering a criteria is then *not* considered in the equation and
  # submitting an answer in the form will not save without the below
  # override.
  def changed_in_place?(raw_old_value, new_value)
    serialize(new_value) != raw_old_value
  end

  def deserialize(value)
    data = super

    cast(data)
  end
end
