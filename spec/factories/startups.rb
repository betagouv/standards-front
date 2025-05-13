require 'faker'

FactoryBot.define do
  factory :startup, class: "EspaceMembre::Startup" do
    ghid { Faker::Lorem.word.downcase }
    uuid { Faker::Internet.uuid }
    name { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    incubator

    trait :in_investigation do
      after(:create) do |startup|
        FactoryBot.create(:phase, :investigation, startup: startup)
      end
    end

    trait :in_construction do
      in_investigation

      after(:create) do |startup|
        startup.latest_phase.terminate!

        FactoryBot.create(:phase, :construction, startup: startup)
      end
    end

    trait :in_acceleration do
      in_construction

      after(:create) do |startup|
        startup.latest_phase.terminate!

        FactoryBot.create(:phase, :acceleration, startup: startup)
      end
    end
  end
end
