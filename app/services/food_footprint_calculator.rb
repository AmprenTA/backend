# frozen_string_literal: true

class FoodFootprintCalculator

  def initialize(food)
    @food = food
  end

  def call
    calculate_carbon_footprint
  end

  private

  attr_reader :food

  def calculate_carbon_footprint
    carbon_footprint_min_max_list = [
      beef_carbon_footprint,
      lamb_carbon_footprint,
      poultry_carbon_footprint,
      fish_carbon_footprint,
      pork_carbon_footprint,
      milk_based_carbon_footprint,
      cheese_carbon_footprint,
      eggs_carbon_footprint,
      coffee_carbon_footprint,
      vegetables_carbon_footprint,
      bread_carbon_footprint
    ]

    [
      carbon_footprint_min_max_list.sum { |interval| interval[0] },
      carbon_footprint_min_max_list.sum { |interval| interval[1] }
    ]
  end

  def beef_carbon_footprint
    food.fetch('beef', 0).map { |n| n * (FoodConstants::BEEF * 100 / 1000.0) }
  end

  def lamb_carbon_footprint
    food.fetch('lamb', 0).map { |n| n * (FoodConstants::LAMB * 100 / 1000.0) }
  end

  def poultry_carbon_footprint
    food.fetch('poultry', 0).map { |n| n * (FoodConstants::POULTRY * 100 / 1000.0) }
  end

  def pork_carbon_footprint
    food.fetch('pork', 0).map { |n| n * (FoodConstants::PORK * 100 / 1000.0) }
  end

  def fish_carbon_footprint
    food.fetch('fish', 0).map { |n| n * (FoodConstants::FISH * 140 / 1000.0) }
  end

  def milk_based_carbon_footprint
    food.fetch('milk_based', 0).map { |n| n * (FoodConstants::MILK_BASED * 200 / 1000.0 * 1.03) }
  end

  def cheese_carbon_footprint
    food.fetch('cheese', 0).map { |n| n * (FoodConstants::CHEESE * 30 / 1000.0) }
  end

  def eggs_carbon_footprint
    food.fetch('eggs', 0).map { |n| n * (FoodConstants::EGGS * 120 / 1000.0) }
  end

  def coffee_carbon_footprint
    food.fetch('coffee', 0).map { |n| n * (FoodConstants::COFFEE * 180 / 1000.0) }
  end

  def vegetables_carbon_footprint
    food.fetch('vegetables', 0).map { |n| n * (FoodConstants::VEGETABLES * 80 / 1000.0) }
  end

  def bread_carbon_footprint
    food.fetch('bread', 0).map { |n| n * (FoodConstants::BREAD * 36 / 1000.0) }
  end
end
