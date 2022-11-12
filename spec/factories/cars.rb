# frozen_string_literal: true

FactoryBot.define do
  factory :car do
    total_km { Faker::Number.between(from: 0.0, to: 2000.0).round(1) }
    fuel_type { %w[diesel benzina gpl ev hybrid].sample }
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
