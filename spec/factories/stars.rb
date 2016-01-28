FactoryGirl.define do
  factory :list_star, class: "Star" do
    association :starable, factory: :list
    starable_id 1
  end

  factory :task_star, class: "Star" do
    association :starable, factory: :task
    starable_id 1
  end
end
