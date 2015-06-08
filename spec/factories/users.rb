require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.name                  Faker::Name.name
    f.email                 Faker::Internet.email
    f.password              ENV['testing_password']
    f.password_confirmation ENV['testing_password']
  end
end