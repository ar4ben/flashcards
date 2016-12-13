FactoryGirl.define do
  factory :card do
    sequence(:original_text) { |n| "run#{n}" }
    sequence(:translated_text) { |n| "бежать#{n}" }
  end
end
