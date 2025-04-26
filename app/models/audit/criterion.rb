class Audit::Criterion
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Serialization

  attribute :label, :string
  attribute :answer, :string, default: nil

  def answered?
    answer.present?
  end

  def inspect
   "<Audit::Criterion label: #{label}, answer: #{answer}>"
  end
end
