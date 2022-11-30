# frozen_string_literal: true

FactoryBot.define do
  factory :car do
    total_km { Faker::Number.between(from: 0.0, to: 2000.0).round(1) }
    fuel_type { Car.fuel_types.values.sample }
    fuel_consumption do
      case fuel_type
      when 0 # diesel
        Faker::Number.between(from: 3.5, to: 15.0).round(1)
      when 1 # petrol
        Faker::Number.between(from: 5.0, to: 20.0).round(1)
      when 2 # GPL
        Faker::Number.between(from: 8.0, to: 18.0).round(1)
      when 3 # EV
        Faker::Number.between(from: 15.0, to: 25.0).round(1)
      when 4 # hybrid
        Faker::Number.between(from: 7.5, to: 15.0).round(1)
      end
    end

    carbon_footprint { CarFootprintCalculator.call(total_km, fuel_consumption, fuel_type) }

    association :footprint
  end

  trait :diesel do
    role { Car.fuel_types[:diesel] }
  end

  trait :petrol do
    role { Car.fuel_types[:petrol] }
  end

  trait :gpl do
    role { Car.fuel_types[:gpl] }
  end

  trait :hybrid do
    role { Car.fuel_types[:hybrid] }
  end

  trait :ev do
    role { Car.fuel_types[:ev] }
  end
end
