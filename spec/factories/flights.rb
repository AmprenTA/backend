# frozen_string_literal: true

FactoryBot.define do
  factory :flight do
    from { Faker::Address.city }
    to { Faker::Address.city }
    carbon_footprint do
      total_km = Faker::Number.between(from: 0.0, to: 4_000.0).round(1)
      FlightFootprintCalculator.call(total_km.to_f)
    end

    association :footprint
  end
end
