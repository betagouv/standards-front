module EspaceMembre
  class Startup < Record
    self.primary_key = "uuid"

    validates :ghid, presence: true

    belongs_to :incubator

    has_many :phases

    has_and_belongs_to_many :missions, join_table: "missions_startups"

    has_many :users, through: :missions

    has_one :evaluation, foreign_key: :startup_uuid

    has_one :latest_phase,
            -> { order(start: :desc) },
            class_name: "Phase",
            inverse_of: :startup

    Phase::PHASES.each do |name|
      define_method "in_#{name}?" do
        latest_phase.send("#{name}?")
      end
    end

    def in_phase?(name)
      send("in_#{name}?")
    end

    def to_s
      name
    end

    def latest_phase
      phases.latest_completed.first
    end

    def evaluation_completion
      if evaluation.nil?
        0
      else
        evaluation.total_completion
      end
    end
  end
end
