FactoryGirl.define do
  factory :task do
    association :list
    priority "low"
    description "do something"
    list_id 1

    factory :invalid_task do
      description nil
    end
  end
end
