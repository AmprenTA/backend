# frozen_string_literal: true

FactoryBot.define do
  factory :public_transport do
    total_km { Faker::Number.between(from: 0.0, to: 2000.0).round(1) }
    transport_type { %w[bus train].sample }
  end

  trait :bus do
    transport_type { PublicTransport.transport_type[:bus] }
  end

  trait :train do
    transport_type { PublicTransport.transport_type[:train] }
  end
end
