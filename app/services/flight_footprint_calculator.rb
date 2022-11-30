# frozen_string_literal: true

class FlightFootprintCalculator
  SMALL_DISTANCE_KG_OF_CO2_PER_KM = 0.3
  LARGER_DISTANCE_KG_OF_CO2_PER_KM = 0.156

  def initialize(distance)
    @distance = distance
  end

  def self.call(distance)
    new(distance).call
  end

  def call
    carbon_footprint
  end

  private

  attr_reader :distance

  def carbon_footprint
    distance * SMALL_DISTANCE_KG_OF_CO2_PER_KM if distance <= 1_000

    distance * LARGER_DISTANCE_KG_OF_CO2_PER_KM
  end
end
