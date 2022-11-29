# frozen_string_literal: true

FactoryBot.define do
  factory :food do
    min_carbon_footprint { Faker::Number.between(from: 0.0, to: 10_000.0).round(1) }
    max_carbon_footprint { Faker::Number.between(from: 0.0, to: 10_000.0).round(1) }
    beef { Food.frequencies.values.sample }
    lamb { Food.frequencies.values.sample }
    poultry { Food.frequencies.values.sample }
    pork { Food.frequencies.values.sample }
    fish { Food.frequencies.values.sample }
    milk_based { Food.frequencies.values.sample }
    cheese { Food.frequencies.values.sample }
    eggs { Food.frequencies.values.sample }
    coffee { Food.frequencies.values.sample }
    vegetables { Food.frequencies.values.sample }
    bread { Food.frequencies.values.sample }

    association :footprint
  end
end
