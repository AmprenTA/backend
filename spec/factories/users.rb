# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.first_name }
    password { Faker::Internet.password }
    location { Faker::Address.city }
  end
end
