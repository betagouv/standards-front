# frozen_string_literal: true

module EspaceMembre
  class Mission < Record
    self.primary_key = "uuid"

    belongs_to :user

    has_and_belongs_to_many :startups, join_table: "missions_startups"

    scope :active, -> { where(end: Time.zone.now..) }
  end
end
