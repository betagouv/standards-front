module EspaceMembre
  class Startup < Record
    self.primary_key = "uuid"

    validates :ghid, presence: true

    has_many :phases
    has_and_belongs_to_many :missions, join_table: "missions_startups"

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
  end
end
