# frozen_string_literal: true

total_footprint_entries = ENV['total_entries'] || 100

puts 'Start seeding...'
0.upto(total_footprint_entries) do |index|
  footprint = Footprint.create

  FactoryBot.create(:house, footprint: footprint)
  FactoryBot.create(:food, footprint: footprint)

  FactoryBot.create(:car, footprint: footprint)
  FactoryBot.create(:flight, footprint: footprint)
  FactoryBot.create(:public_transport, footprint: footprint)
  # TODO: update the frequencies for each type
end
puts 'Seeding complete!'
