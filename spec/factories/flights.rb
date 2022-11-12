# frozen_string_literal: true

FactoryBot.define do
  factory :flight do
    from { Faker::Address.city }
    to { Faker::Address.city }
  end
end
