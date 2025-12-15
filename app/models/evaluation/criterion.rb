class Evaluation::Criterion
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Serialization

  ANSWERS = {
    "yes" => "Oui",
    "no" => "Non",
    "na" => "Non applicable"
  }

  CONSIDERED_PASS = %w[yes na]

  attribute :label, :string
  attribute :answer, :string, default: nil

  def blank?
    answer.blank?
  end

  def complete?
    !blank?
  end

  def done?
    [ "yes", "na" ].include?(answer)
  end

  def inspect
   "<Evaluation::Criterion label: #{label}, answer: #{answer}>"
  end
end
