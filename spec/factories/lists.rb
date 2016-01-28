FactoryGirl.define do
  factory :list do
    association :user
    name "To Do"
    user_id 1

    factory :invalid_list do
      name nil
    end
  end
end
