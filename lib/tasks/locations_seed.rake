# frozen_string_literal: true

namespace :locations do
  desc 'Data seeding task with locations'
  task seed: :environment do
    puts 'Start seeding...'

    api_base_url = 'https://roloca.coldfuse.io'
    counties_url = "#{api_base_url}/judete"
    counties = LocationsCall.call(counties_url)

    counties.each do |county|
      county_auto = county['auto']
      county_name = county['nume']

      county_url = "#{api_base_url}/orase/#{county_auto}"
      towns = LocationsCall.call(county_url)
      towns.each do |town|
        Location.create(
          county: county_name,
          town: town['nume']
        )
      end
    end

    puts 'Seeding complete!'
  end
end
