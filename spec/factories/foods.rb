# frozen_string_literal: true

FactoryBot.define do
  factory :food do
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

    min_carbon_footprint do
      params = {
        beef:,
        lamb:,
        poultry:,
        pork:,
        fish:,
        milk_based:,
        cheese:,
        eggs:,
        coffee:,
        vegetables:,
        bread:
      }
      min, = FoodFootprintCalculator.call(params)
      min
    end

    max_carbon_footprint do
      params = {
        beef:,
        lamb:,
        poultry:,
        pork:,
        fish:,
        milk_based:,
        cheese:,
        eggs:,
        coffee:,
        vegetables:,
        bread:
      }
      _, max = FoodFootprintCalculator.call(params)
      max
    end

    association :footprint
  end
end
