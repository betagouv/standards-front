require 'faker'

FactoryBot.define do
  factory :incubator, class: 'EspaceMembre::Incubator' do
    ghid { Faker::Lorem.word.downcase }
    uuid { Faker::Internet.uuid }
    title { Faker::Lorem.word }
  end
end
