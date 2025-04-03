FactoryBot.define do
  factory :audit do
    association :startup, factory: :startup, strategy: :build
    startup_uuid { startup.uuid }
    data { { "accessibility" => 3, "design" => 4, "security" => 2 } }
  end
end
