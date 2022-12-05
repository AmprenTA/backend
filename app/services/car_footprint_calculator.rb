# frozen_string_literal: true

class CarFootprintCalculator
  DIESEL = 2.7
  PETROL = 2.3
  GPL = 1.6
  EV = 0.053
  HYBRID = 0.109

  def initialize(total_km, fuel_consumption, fuel_type)
    @total_km = total_km
    @fuel_consumption = fuel_consumption
    @fuel_type = fuel_type
  end

  def self.call(total_km, fuel_consumption, fuel_type)
    new(total_km, fuel_consumption, fuel_type).call
  end

  def call
    carbon_footprint
  end

  private

  attr_reader :total_km, :fuel_consumption, :fuel_type

  def carbon_footprint
    liters_or_kwh_per_km = fuel_consumption / 100.0
    total_liters_or_kwh = total_km * liters_or_kwh_per_km

    total_liters_or_kwh * fuel_type_mapping
  end

  def fuel_type_mapping
    case fuel_type
    when 0
      DIESEL
    when 1
      PETROL
    when 2
      GPL
    when 3
      EV
    when 4
      HYBRID
    end
  end
end
