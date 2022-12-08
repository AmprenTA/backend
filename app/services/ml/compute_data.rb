# frozen_string_literal: true

module Ml
  # rubocop:disable Metrics/ClassLength, Metrics/MethodLength, Metrics/AbcSize:
  class ComputeData
    def initialize(required_footprints)
      @required_footprints = required_footprints
    end

    def call
      compute_plot_data
    end

    def self.call(required_footprints)
      new(required_footprints).call
    end

    private

    attr_reader :required_footprints

    def endpoint_url
      ''
    end

    def endpoint_data
      Ml::RetrieveParams.call(endpoint_url)
    end

    def coefficients
      [
        0.2776026, # electricity
        2.19059814, # natural_gas
        2.71443488, # wood
        104.33954206, # beef
        42.82043055, # lamb
        11.72830666, # poultry
        13.73803643, # pork
        11.62259008, # fish
        7.88822509, # milk_based
        12.05441373, # cheese
        8.30599958, # eggs
        53.5329533, # coffee
        2.14525392, # vegetables
        0.70737383, # bread
        -78.86368905, # fuel_type
        9.54647867, # fuel_consumption
        0.17373725, # total_km_car
        54.91283659, # transport_type
        0.27116935 # total_km_public
      ]
    end

    def intercept
      -191.45874342
    end

    def kg
      1000.0 # 1000 g = 1 kg
    end

    def footprints
      Footprint
        .includes(:cars, :flights, :public_transports, :house, :food)
        .first(required_footprints)
    end

    def compute_plot_data
      means_data = []
      cumulative_sum = 0

      footprints.each_with_index do |footprint, index|
        # validate with Anastasia the format
        current_sum = compute_value_for(footprint)
        cumulative_sum += current_sum
        avg_sum = cumulative_sum / (index + 1)
        # means_data << [avg_sum, index]
        means_data << avg_sum
      end

      means_data
    end

    def compute_value_for(footprint)
      (coefficients[0] * electricity(footprint)) +
        (coefficients[1] * natural_gas(footprint)) +
        (coefficients[2] * wood(footprint)) +
        (coefficients[3] * beef(footprint)) +
        (coefficients[4] * lamb(footprint)) +
        (coefficients[5] * poultry(footprint)) +
        (coefficients[6] * pork(footprint)) +
        (coefficients[7] * fish(footprint)) +
        (coefficients[8] * milk_based(footprint)) +
        (coefficients[9] * cheese(footprint)) +
        (coefficients[10] * eggs(footprint)) +
        (coefficients[11] * coffee(footprint)) +
        (coefficients[12] * vegetables(footprint)) +
        (coefficients[13] * bread(footprint)) +
        (coefficients[14] * fuel_type(footprint)) +
        (coefficients[15] * fuel_consumption(footprint)) +
        (coefficients[16] * total_km_car(footprint)) +
        (coefficients[17] * transport_type(footprint)) +
        (coefficients[18] * total_km_public(footprint)) +
        intercept
    end

    def electricity(footprint)
      footprint.house.electricity
    end

    def natural_gas(footprint)
      footprint.house.natural_gas
    end

    def wood(footprint)
      footprint.house.wood
    end

    def beef(footprint)
      beef = footprint.food.beef
      min, max = frequency(beef).map { |n| n * (FoodConstants::BEEF * 100 / kg) }
      (min + max) / 2.0
    end

    def lamb(footprint)
      lamb = footprint.food.lamb
      min, max = frequency(lamb).map { |n| n * (FoodConstants::LAMB * 100 / kg) }
      (min + max) / 2.0
    end

    def poultry(footprint)
      poultry = footprint.food.poultry
      min, max = frequency(poultry).map { |n| n * (FoodConstants::POULTRY * 100 / kg) }
      (min + max) / 2.0
    end

    def pork(footprint)
      pork = footprint.food.pork
      min, max = frequency(pork).map { |n| n * (FoodConstants::PORK * 100 / kg) }
      (min + max) / 2.0
    end

    def fish(footprint)
      fish = footprint.food.fish
      min, max = frequency(fish).map { |n| n * (FoodConstants::FISH * 140 / kg) }
      (min + max) / 2.0
    end

    def milk_based(footprint)
      milk_based = footprint.food.milk_based
      min, max = frequency(milk_based).map { |n| n * (FoodConstants::MILK_BASED * 200 / kg * 1.03) }
      (min + max) / 2.0
    end

    def cheese(footprint)
      cheese = footprint.food.cheese
      min, max = frequency(cheese).map { |n| n * (FoodConstants::CHEESE * 30 / kg) }
      (min + max) / 2.0
    end

    def eggs(footprint)
      eggs = footprint.food.eggs
      min, max = frequency(eggs).map { |n| n * (FoodConstants::EGGS * 120 / kg) }
      (min + max) / 2.0
    end

    def coffee(footprint)
      coffee = footprint.food.coffee
      min, max = frequency(coffee).map { |n| n * (FoodConstants::COFFEE * 180 / kg) }
      (min + max) / 2.0
    end

    def vegetables(footprint)
      vegetables = footprint.food.vegetables
      min, max = frequency(vegetables).map { |n| n * (FoodConstants::VEGETABLES * 80 / kg) }
      (min + max) / 2.0
    end

    def bread(footprint)
      bread = footprint.food.bread
      min, max = frequency(bread).map { |n| n * (FoodConstants::BREAD * 36 / kg) }
      (min + max) / 2.0
    end

    def flights(footprint)
      footprint.flights
    end

    # TODO: Where do we add the flight carbon_footprint
    def cars(footprint)
      footprint.cars
    end

    def fuel_type(footprint)
      total = cars(footprint).size
      return 0 if total.zero?

      sum = cars(footprint).sum { |car| Car.fuel_types[car.fuel_type] }
      sum / total
    end

    def fuel_consumption(footprint)
      total = cars(footprint).size
      return 0 if total.zero?

      cars(footprint).sum(&:fuel_consumption) / total
    end

    def total_km_car(footprint)
      total = cars(footprint).size
      return 0 if total.zero?

      cars(footprint).sum(&:total_km) / total
    end

    def public_transports(footprint)
      footprint.public_transports
    end

    def transport_type(footprint)
      total = public_transports(footprint).size
      return 0 if total.zero?

      sum = public_transports(footprint).sum { |pt| PublicTransport.transport_types[pt.transport_type] }
      sum / total
    end

    def total_km_public(footprint)
      total = public_transports(footprint).size
      return 0 if total.zero?

      public_transports(footprint).sum(&:total_km) / total
    end

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
  end
  # rubocop:enable Metrics/ClassLength, Metrics/MethodLength, Metrics/AbcSize:
end
