FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    sequence(:identifier) {|n| "personx#{n}"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      level 0
    end
  end
end