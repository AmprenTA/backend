# frozen_string_literal: true

class FoodFootprintCalculator
  KG = 1000.0 # 1000 g = 1 kg

  def initialize(food)
    @food = food
  end

  def self.call(food)
    new(food).call
  end

  def call
    calculate_carbon_footprint
  end

  private

  attr_reader :food

  def frequency(value)
    case value
    when 0
      [0, 0] # never
    when 1
      [1, 2] # once/twice a month
    when 2
      [4, 8] # once/twice a week
    when 3
      [20, 30] # everyday
    when 4
      [60, 90] # multiple times a day
    end
  end

  def calculate_carbon_footprint
    carbon_footprint_min_max_list = aggregated_footprints

    [
      carbon_footprint_min_max_list.sum { |interval| interval[0] },
      carbon_footprint_min_max_list.sum { |interval| interval[1] }
    ]
  end

  def aggregated_footprints
    [
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
  end

  def beef_carbon_footprint
    beef = food.fetch('beef', 0)
    frequency(beef).map { |n| n * (FoodConstants::BEEF * 100 / KG) }
  end

  def lamb_carbon_footprint
    lamb = food.fetch('lamb', 0)
    frequency(lamb).map { |n| n * (FoodConstants::LAMB * 100 / KG) }
  end

  def poultry_carbon_footprint
    poultry = food.fetch('poultry', 0)
    frequency(poultry).map { |n| n * (FoodConstants::POULTRY * 100 / KG) }
  end

  def pork_carbon_footprint
    pork = food.fetch('pork', 0)
    frequency(pork).map { |n| n * (FoodConstants::PORK * 100 / KG) }
  end

  def fish_carbon_footprint
    fish = food.fetch('fish', 0)
    frequency(fish).map { |n| n * (FoodConstants::FISH * 140 / KG) }
  end

  def milk_based_carbon_footprint
    milk_based = food.fetch('milk_based', 0)
    frequency(milk_based).map { |n| n * (FoodConstants::MILK_BASED * 200 / KG * 1.03) }
  end

  def cheese_carbon_footprint
    cheese = food.fetch('cheese', 0)
    frequency(cheese).map { |n| n * (FoodConstants::CHEESE * 30 / KG) }
  end

  def eggs_carbon_footprint
    eggs = food.fetch('eggs', 0)
    frequency(eggs).map { |n| n * (FoodConstants::EGGS * 120 / KG) }
  end

  def coffee_carbon_footprint
    coffee = food.fetch('coffee', 0)
    frequency(coffee).map { |n| n * (FoodConstants::COFFEE * 180 / KG) }
  end

  def vegetables_carbon_footprint
    vegerables = food.fetch('vegetables', 0)
    frequency(vegerables).map { |n| n * (FoodConstants::VEGETABLES * 80 / KG) }
  end

  def bread_carbon_footprint
    bread = food.fetch('bread', 0)
    frequency(bread).map { |n| n * (FoodConstants::BREAD * 36 / KG) }
  end
end
