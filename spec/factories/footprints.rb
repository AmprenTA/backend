# frozen_string_literal: true

FactoryBot.define do
  factory :footprint do
    house
    # food
    flight
    car
    public_transport
  end
end
