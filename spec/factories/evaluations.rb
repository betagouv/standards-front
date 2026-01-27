FactoryBot.define do
  factory :evaluation do
    startup
    version { "test" }
    questions { Evaluation.from_latest_standards.questions }

    trait :complete do
      after(:create) do |instance|
        instance.categories.each do |category|
          instance.standards_for(category).each do |question|
            question.criteria.each do |crit|
              crit.answer = "yes"
            end
          end
        end

        instance.save!
      end
    end
  end
end
