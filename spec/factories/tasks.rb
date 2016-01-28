FactoryGirl.define do
  factory :task do
    association :list
    priority "low"
    description "do something"
  end
end
