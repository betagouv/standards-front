# frozen_string_literal: true

module EspaceMembre
  class MissionStartup < Record
    self.primary_key = "uuid"

    belongs_to :mission
    belongs_to :startup_id
  end
end
