require 'faker'

FactoryBot.define do
  factory :phase do
    uuid { Faker::Internet.uuid }
    start { Time.zone.now }
    name { Faker::Lorem.word }

    Phase::PHASES.each do |phase_name|
      trait phase_name do
        name { phase_name }
      end
    end
  end
end
