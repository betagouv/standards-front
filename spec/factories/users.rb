# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user, class: 'EspaceMembre::User' do
    username { Faker::Internet.username }
    uuid { Faker::Internet.uuid }
    fullname { Faker::Name.name }
    domaine { EspaceMembre::User::DOMAINES.sample }
    role { Faker::Job.title }

    trait :with_active_mission do
      after(:create) do |user|
        user.missions.create!(start: Time.zone.now, end: Time.now.next_week)
      end
    end
  end
end
