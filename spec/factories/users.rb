FactoryGirl.define do
  factory :user do
    username "Billie"
    password "password"
    password_confirmation "password"

    factory :invalid_user do
      username nil
    end
  end
end
