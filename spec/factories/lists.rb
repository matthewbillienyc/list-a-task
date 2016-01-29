FactoryGirl.define do
  factory :list do
    association :user
    name "To Do"

    factory :invalid_list do
      name nil
    end
  end
end
