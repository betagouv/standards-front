require 'faker'

FactoryBot.define do
  factory :phase, class: 'EspaceMembre::Phase' do
    uuid { Faker::Internet.uuid }
    start { Time.zone.now }
    name { Faker::Lorem.word }

    EspaceMembre::Phase::PHASES.each do |phase_name|
      trait phase_name do
        name { phase_name }
      end
    end
  end
end
