# frozen_string_literal: true

module EspaceMembre
  class Startup < Record
      ACTIVE_PHASES = [
        :construction,
        :acceleration,
        :opere,
        :consolidation
      ].freeze

      class << self
        def active
          in_phase(*ACTIVE_PHASES)
        end
      end
  end
end
