FactoryGirl.define do
  factory :list_star, class: "Star" do
    association :starable, factory: :list
  end

  factory :task_star, class: "Star" do
    association :starable, factory: :task
  end
end
