# frozen_string_literal: true

FactoryBot.define do
  factory :flight do
    from { Faker::Address.city }
    to { Faker::Address.city }
    carbon_footprint { Faker::Number.between(from: 0.0, to: 10000.0).round(1) }

    association :footprint
  end
end
