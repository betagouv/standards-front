require 'faker'

FactoryBot.define do
  factory :question, class: "Evaluation::Question" do
    category { %w[accessibilité vie-privée].sample }
    title { Faker::Lorem.sentence }
    id { Faker::Alphanumeric.alpha }
    description { Faker::Lorem.paragraphs.join("\n") }
    criteria { [ label: Faker::Lorem.sentence ] }
  end
end
