# frozen_string_literal: true

module Statistics
  class CityEmissions
    def initialize(location = nil)
      @location = location
    end

    def self.call(location = nil)
      new(location).call
    end

    def call
      compute_average
    end

    private

    attr_reader :location

    def compute_average
      footprints = Footprint.footprints_by_category_by_location(location)

      min_food_footprints_average = footprints[:min_food_footprints].size.positive? ? footprints[:min_food_footprints].sum / footprints[:min_food_footprints].size : 0
      max_food_footprints_average = footprints[:max_food_footprints].size.positive? ? footprints[:max_food_footprints].sum / footprints[:max_food_footprints].size : 0
      cars_footprints_average = footprints[:cars_footprints].size.positive? ? footprints[:cars_footprints].sum / footprints[:cars_footprints].size : 0
      house_footprints_average = footprints[:house_footprints].size.positive? ? footprints[:house_footprints].sum / footprints[:house_footprints].size : 0
      flights_footprints_average = footprints[:flights_footprints].size.positive? ? footprints[:flights_footprints].sum / footprints[:flights_footprints].size : 0
      public_transports_footprints_average = footprints[:public_transports_footprints].size.positive? ? footprints[:public_transports_footprints].sum / footprints[:public_transports_footprints].size : 0

      food_footprints_average = (min_food_footprints_average + max_food_footprints_average) / 2
      transportation_footprints_average = (cars_footprints_average + flights_footprints_average + public_transports_footprints_average) / 3

      {
        food_footprints_average:,
        house_footprints_average:,
        transportation_footprints_average:
      }
    end
  end
end
