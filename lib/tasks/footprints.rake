# frozen_string_literal: true

require 'csv'

namespace :footprints do
  desc 'Data seeding task with carbon footprints'
  task seed: :environment do
    puts 'Start seeding...'
    footprints_dates = %w[02/06/2023 02/05/2023 02/04/2023 02/03/2023 02/02/2023 02/01/2023 02/12/2022 02/11/2022 02/10/2022 02/09/2022]
    locations = Location.pluck(:county).uniq.compact
    locations.sort!
    footprints_dates.each do |date|
      locations.each do |location|
        footprint = Footprint.create!(location:, created_at: date)
        FactoryBot.create(:car, footprint:, created_at: date)
        FactoryBot.create(:flight, footprint:, created_at: date)
        FactoryBot.create(:food, footprint:, created_at: date)
        FactoryBot.create(:house, footprint:, created_at: date)
        FactoryBot.create(:public_transport, footprint:, created_at: date)
      end
    end
    puts 'Seeding complete!'
  end
end
