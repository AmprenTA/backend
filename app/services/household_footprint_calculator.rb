# frozen_string_literal: true

class HouseholdFootprintCalculator
  ELECTRICITY = 0.3
  NATURAL_GAS = 2.2
  WOOD = 4.6

  def initialize(electricity, natural_gas, wood)
    @electricity = electricity
    @natural_gas = natural_gas
    @wood = wood
  end

  def self.call(electricity, natural_gas, wood)
    new(electricity, natural_gas, wood).call
  end

  def call
    calculate_footprint
  end

  private

  attr_reader :electricity, :natural_gas, :wood

  def calculate_footprint
    (ELECTRICITY * electricity) + (NATURAL_GAS * natural_gas) + (WOOD * wood)
  end
end
