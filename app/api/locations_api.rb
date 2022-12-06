# frozen_string_literal: true

class LocationsApi < Grape::API
  format :json
  resource :locations do
    # GET /locations
    desc 'Get available locations' do
      tags %w[locations]
      http_codes [
        { code: 200, message: 'Locations list.' }
      ]
    end
    get do
      locations = Location.all.map(&:to_s)
      locations_list = ((0...locations.size).zip locations)
                       .map { |location| { 'id' => location[0], 'name' => location[1] } }

      present locations_list
    end
  end
end
