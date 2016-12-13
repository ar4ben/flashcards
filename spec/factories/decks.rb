FactoryGirl.define do
  factory :deck do
    sequence(:name) { |n| "name#{n}" }
  end
end
