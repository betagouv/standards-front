
class Evaluation::Question
  extend AskCollection

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

  asks :blank?, to: :criteria
  asks :complete?, to: :criteria
  asks :conform?, to: :criteria, via: :done?

  def criteria
    @criteria ||= self.attributes["criteria"].map { |crit| Evaluation::Criterion.new(crit) }
  end

  def presented
    QuestionPresenter.new(self)
  end

  # this whole bit allows saying "a standard is equal to another
  # standard if they have the same title/ID", c.f EvaluationUpgrader.
  def hash
    [ self.class, self.id ].hash
  end

  def eql?(other)
    self == other
  end

  def ==(other)
    false if id.nil?

    id == other.id
  end

  def inspect
   "<Evaluation::Question title: #{title}>"
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
