module EspaceMembre
  class Incubator < Record
    self.primary_key = "uuid"

    validates :ghid, presence: true

    has_many :startups
  end
end
