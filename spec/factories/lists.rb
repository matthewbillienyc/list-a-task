FactoryGirl.define do
  factory :list do
    association :user
    name "To Do"
  end
end
