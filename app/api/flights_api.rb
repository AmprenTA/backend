# frozen_string_literal: true

class FlightsApi < Grape::API
  format :json
  resource :flights do
    namespace 'airports' do
      # GET /flights/airports
      desc 'Get available airports' do
        tags %w[flights]
        http_codes [
          { code: 200, message: 'Airports list.' }
        ]
      end
      get do
        airports = FlightsDistance.all.map { |flight| flight['to'] }.uniq |
                   FlightsDistance.all.map { |flight| flight['from'] }.uniq
        airports_list = ((0...airports.size).zip airports).map { |list| { 'id' => list[0], 'name' => list[1] } }
        present airports_list
      end
    end
  end
end
