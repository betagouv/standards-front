# frozen_string_literal: true

require "espace_membre/record"

module EspaceMembre
  class Startup < Record
    has_one :evaluation, foreign_key: :startup_uuid, inverse_of: :startup

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
