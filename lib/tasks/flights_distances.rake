# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'
require 'csv'
require 'json'

def call_to_api(from, to)
  url = URI("https://aerodatabox.p.rapidapi.com/airports/iata/#{from}/distance-time/#{to['IATA']}")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(url)
  request['X-RapidAPI-Key'] = ENV.fetch('RAPID_API_KEY', nil)
  request['X-RapidAPI-Host'] = ENV.fetch('RAPID_API_HOST', nil)
  JSON.parse(http.request(request).body)
end

namespace :flights do
  desc 'Generate CSV with distances between usual airports in Romania'
  task :generate_distances_csv do
    puts 'Beginning generating CSV...'
    iata_from = %w[SCV IAS CLJ OTP]

    csv_path = Rails.root.join('lib/IATA_codes.csv')
    csv_text = File.read(csv_path)
    csv = CSV.parse(csv_text, headers: true)

    file = Rails.root.join('lib/distances.csv')
    headers = 'from,to,km'
    begin
      iata_from.each do |from|
        csv.each do |to|
          response = call_to_api(from, to)
          next if response.size <= 1

          data = [
            response.fetch('from', '').fetch('municipalityName', ''),
            response.fetch('to', '').fetch('municipalityName', ''),
            response.fetch('greatCircleDistance', '').fetch('km', '')
          ]
          CSV.open(file, 'a', headers:) do |distances_csv|
            distances_csv << data
          end
          sleep 1
        end
        puts "Distances for flights from #{from} done!"
      end
      puts 'CSV generated successfully!'
    rescue StandardError => e
      puts e
    end
  end
end
