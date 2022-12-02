# frozen_string_literal: true

FactoryBot.define do
  factory :house do
    electricity { Faker::Number.between(from: 20.0, to: 150.0).round(1) }
    natural_gas { Faker::Number.between(from: 0.0, to: 150.0).round(1) }
    wood do
      if natural_gas > 10
        0.0
      else
        Faker::Number.between(from: 0.0, to: 2.5).round(1)
      end
    end
    carbon_footprint { HouseholdFootprintCalculator.call(electricity, natural_gas, wood) }

    association :footprint
  end
end
