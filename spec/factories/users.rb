require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.name                  Faker::Name.name
    f.email                 Faker::Internet.email
    f.password              TESTING_PASSWORD
    f.password_confirmation TESTING_PASSWORD
  end
end