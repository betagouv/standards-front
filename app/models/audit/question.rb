
class Audit::Question
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Serialization

  attribute :id, :string
  attribute :category, :string
  attribute :resources, default: -> { [] }
  attribute :title, :string
  attribute :description, :string
  attribute :criteria, default: -> { [] }
  attribute :last_modified_on, :date

  def criteria
    @criteria ||= self.attributes["criteria"].map { |crit| Audit::Criterion.new(crit) }
  end

  def inspect
   "<Audit::Question title: #{title}>"
  end

  def complete?
    criteria.all?(&:done?)
  end

  def partially_complete?
    criteria.any?(&:done?)
  end

  def answered?
    criteria.any?(&:answered?)
  end

  def all_nos?
    criteria.all?(&:negative?)
  end

  def unanswered?
    !answered?
  end

  # Override serializable_hash to properly handle criteria
  def serializable_hash(options = nil)
    options ||= {}

    hash = super(options)

    # Replace criteria with properly serialized criteria
    if hash.key?("criteria")
      hash["criteria"] = criteria.map(&:serializable_hash)
    end

    hash
  end

  def as_json(options = nil)
    serializable_hash(options)
  end
end
