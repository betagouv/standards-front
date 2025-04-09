FactoryBot.define do
  factory :audit do
    association :startup, factory: :startup, strategy: :build
    startup_uuid { startup.uuid }
  end
end
