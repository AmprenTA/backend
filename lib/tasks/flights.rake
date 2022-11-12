# frozen_string_literal: true
require 'uri'
require 'net/http'
require 'openssl'
require 'csv'

desc 'Populate database with IATA codes'
task :seed_iata_codes do
  puts 'Start seeding...'
  url = URI(ENV.fetch('RAPID_API_URI', nil))
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(url)
  request['X-RapidAPI-Key'] = ENV.fetch('RAPID_API_KEY', nil)
  request['X-RapidAPI-Host'] = ENV.fetch('RAPID_API_HOST', nil)
  response = http.request(request)
  iata_codes = Hash.from_xml(response.body)['Airports']['Airport']
                   .each { |n| n.select! { |k, _| k if %w[State Longitude Latitude].exclude?(k) } }
  file = Rails.root.join('lib/IATA_codes.csv')
  headers = 'IATACode,Country,Name'
  CSV.open(file, "w", headers: headers, write_headers: true) do |csv|
    iata_codes.each do |row|
      csv << row
    end
  end
  puts 'Seeding complete!'
end
