require 'faker'

FactoryGirl.define do
  factory :blog do |f|
    f.title Faker::Name.name
    f.body  Faker::Lorem.paragraph
  end
end