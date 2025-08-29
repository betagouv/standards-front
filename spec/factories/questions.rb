require 'faker'

FactoryBot.define do
  factory :question, class: "Evaluation::Question" do
    domaine { %w[accessibilité vie-privée].sample }
    title { Faker::Lorem.sentence }
  end
end
