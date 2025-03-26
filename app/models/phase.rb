require_relative "espace_membre_record"

class Phase < EspaceMembreRecord
  belongs_to :startup

  PHASES = [
    "investigation",
    "construction",
    "acceleration",
    "success",
    "alumni",
    "transfer"
  ]

  scope :latest_completed, -> { order(start: :desc) }

  PHASES.each do |phase|
    # define scopes for each state (Phase.success, Phase.alumni, etc.)
    scope phase, -> { where("phases.name": phase) }

    # define individual instance methods
    define_method "#{phase}?" do
      name == phase
    end
  end

  scope :active_phase, -> { construction.or(acceleration) }

  def terminate!
    update!(end: Time.zone.now)
  end
end
