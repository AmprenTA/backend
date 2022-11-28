# frozen_string_literal: true

class FlightFootprintCalculator
  KG_OF_CO2_PER_KM = 0.156

  def initialize(distance)
    @distance = distance
  end

  def self.call(distance)
    new(distance).call
  end

  def call
    calculate_carbon_footprint
  end

  private

  attr_reader :distance

  def calculate_carbon_footprint
    distance * KG_OF_CO2_PER_KM
  end
end
