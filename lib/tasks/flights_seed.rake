# frozen_string_literal: true

require 'csv'

namespace :flights do
  desc 'Data seeding task with flights distances'
  task distances_seed: :environment do
    puts 'Start seeding...'
    csv_path = Rails.root.join('lib/distances.csv')
    csv_text = File.read(csv_path)
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      flight_parameters = row.to_hash
      flight_carbon_footprint = FlightFootprintCalculator.call(flight_parameters['km'].to_f)
      flight_parameters['carbon_footprint'] = flight_carbon_footprint
      FlightDistance.find_or_create_by(flight_parameters)
    end
    puts 'Seeding complete!'
  end
end
