# frozen_string_literal: true

FLIGHTS_PERCENTAGE_PER_MONTH = 0.0842 # 8.42%
total_footprint_entries = ENV['total_footprints'].to_i || 1_000

total_flights = (total_footprint_entries * FLIGHTS_PERCENTAGE_PER_MONTH).ceil
total_cars = (((60..72).to_a.sample * total_footprint_entries)/100).ceil
total_public_transports = (((25..60).to_a.sample * total_footprint_entries)/100).ceil

puts 'Start seeding...'

0.upto(total_footprint_entries) do |index|
  footprint = Footprint.create

  FactoryBot.create(:house, footprint: footprint)
  FactoryBot.create(:food, footprint: footprint)

  FactoryBot.create(:car, footprint: footprint) if index <= total_cars

  FactoryBot.create(:public_transport, footprint: footprint) if index <= total_public_transports

  FactoryBot.create(:flight, footprint: footprint) if index <= total_flights + 1
end

puts 'Seeding complete!'
