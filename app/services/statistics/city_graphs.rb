# frozen_string_literal: true

module Statistics
  class CityGraphs
    def initialize(location = nil)
      @location = location
    end

    def self.call(location = nil)
      new(location).call
    end

    def call
      graph_data
    end

    private

    attr_reader :location

    def graph_data
      footprints = Footprint.footprints_by_category_with_timestamps_and_location(location)
      average_food_footprints = []
      footprints[:min_food_footprints].each_with_index do |min_footprint, index|
        max_footprint = footprints[:max_food_footprints][index]
        average = (min_footprint[0] + max_footprint[0]) / 2
        timestamp = min_footprint[1]
        average_food_footprints << [average, timestamp]
      end

      # Get the summed transportation footprints
      transportation_footprints = []
      footprints[:cars_footprints].each_with_index do |cars_footprint, index|
        flights_footprint = footprints[:flights_footprints][index][0]
        public_transports_footprint = footprints[:public_transports_footprints][index][0]
        summed_footprint = (cars_footprint[0] + flights_footprint + public_transports_footprint) / 3.0
        timestamp = cars_footprint[1]
        transportation_footprints << [summed_footprint, timestamp]
      end

      average_food_footprints.uniq! { |subarray| subarray[1] }
      transportation_footprints.uniq! { |subarray| subarray[1] }
      footprints[:house_footprints].uniq! { |subarray| subarray[1] }

      total_carbon_footprints = []
      average_food_footprints.each_with_index do |average_food_footprint, index|
        total_carbon_footprint = average_food_footprint[0] + transportation_footprints[index][0] + footprints[:house_footprints][index][0]
        timestamp = average_food_footprint[1]
        total_carbon_footprints << [total_carbon_footprint, timestamp]
      end

      {
        average_food_footprints:,
        transportation_footprints:,
        house_footprints: footprints[:house_footprints],
        carbon_footprint_difference: total_carbon_footprints.length > 1 ? total_carbon_footprints[-1][0] - total_carbon_footprints[-2][0] : 'N/A'
      }
    end
  end
end
