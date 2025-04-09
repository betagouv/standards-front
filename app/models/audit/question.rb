
class Audit::Question
  include ActiveModel::Serialization
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :id, :string
  attribute :category, :string
  attribute :resources, default: -> { [] }
  attribute :title, :string
  attribute :description, :string
  attribute :criteria, default: -> { [] }

  def criteria
    @criteria ||= self.attributes["criteria"].map { |crit| Audit::Criterion.new(crit) }
  end

  def inspect
   "<Audit::Question title: #{title}>"
  end

  def complete?
    criteria.all?(&:answered?)
  end
end
