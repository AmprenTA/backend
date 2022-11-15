# frozen_string_literal: true

FactoryBot.define do
  factory :food do
    min_carbon_footprint { Faker::Number.between(from: 0.0, to: 10_000.0).round(1) }
    max_carbon_footprint { Faker::Number.between(from: 0.0, to: 10_000.0).round(1) }

    association :footprint
  end
end
