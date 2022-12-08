# frozen_string_literal: true

module Statistics
  class AverageFootprint
    def initialize(location = nil, month = nil)
      @location = location
      @month = month
    end

    def self.call(location = nil)
      new(location).call
    end

    def call
      compute_average
    end

    private

    attr_reader :location, :month

    def general_footprints
      Footprint
        .includes(:cars, :flights, :public_transports, :house, :food)
        .all
    end

    def footprints_for(location)
      Footprint
        .includes(:cars, :flights, :public_transports, :house, :food)
        .where(location:)
    end

    def cars_avg_footprint(footprints)
      total = footprints.size
      footprint_sum = footprints.sum do |footprint|
        footprint.cars.sum(&:carbon_footprint)
      end
      footprint_sum / total
    end

    def flights_avg_footprint(footprints)
      total = footprints.size
      footprint_sum = footprints.sum do |footprint|
        footprint.flights.sum(&:carbon_footprint)
      end
      footprint_sum / total
    end

    def public_transport_avg_footprint(footprints)
      total = footprints.size
      footprint_sum = footprints.sum do |footprint|
        footprint.public_transports.sum(&:carbon_footprint)
      end
      footprint_sum / total
    end

    def house_avg_footprint(footprints)
      total = footprints.size
      footprints.sum { |footprint| footprint.house.carbon_footprint } / total
    end

    def food_avg_footprint(footprints)
      total = footprints.size
      min = footprints.sum { |footprint| footprint.food.min_carbon_footprint } / total
      max = footprints.sum { |footprint| footprint.food.max_carbon_footprint } / total
      [min, max]
    end

    def specific_footprints
      if location
        footprints_for(location)
      elsif month
        footprints_by(month)
      else
        general_footprints
      end
    end

    def compute_average
      footprints = specific_footprints

      cars_carbon_footprint = cars_avg_footprint(footprints)
      public_transports_carbon_footprint = public_transport_avg_footprint(footprints)
      flights_carbon_footprint = flights_avg_footprint(footprints)
      transportation_carbon_footprint = cars_carbon_footprint +
                                        flights_carbon_footprint +
                                        public_transports_carbon_footprint

      house_carbon_footprint = house_avg_footprint(footprints)
      min, max = food_avg_footprint(footprints)
      average = (min + max) / 2.0

      {
        transportation_carbon_footprint:,
        house_carbon_footprint:,
        food_carbon_footprint: { min:, max:, average: }
      }
    end
  end
end
