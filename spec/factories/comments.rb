require 'faker'

FactoryGirl.define do
  factory :comment do |f|
    f.body  Faker::Lorem.paragraph

    association :user, factory: :user
  end
end