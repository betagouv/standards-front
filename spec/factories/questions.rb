require 'faker'

FactoryBot.define do
  factory :question, class: "Audit::Question" do
    domaine { %w[accessibilité vie-privée].sample }
    title { Faker::Lorem.sentence }
  end
end
