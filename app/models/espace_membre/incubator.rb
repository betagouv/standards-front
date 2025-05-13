module EspaceMembre
  class Incubator < Record
    self.primary_key = "uuid"

    validates :ghid, presence: true

    has_many :startups

    def to_s
      title
    end
  end
end
