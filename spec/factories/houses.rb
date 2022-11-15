# frozen_string_literal: true

FactoryBot.define do
  factory :house do
    electricity { Faker::Number.between(from: 0.0, to: 10.0).round(1) }
    natural_gas { Faker::Number.between(from: 0.0, to: 10.0).round(1) }
    wood { Faker::Number.between(from: 0.0, to: 10.0).round(1) }
    carbon_footprint { Faker::Number.between(from: 0.0, to: 10000.0).round(1) }

    association :footprint
  end
end
