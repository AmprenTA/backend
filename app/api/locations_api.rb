# frozen_string_literal: true

class LocationsApi < Grape::API
  format :json

  resource :locations do
    # GET /locations/counties
    desc 'Get available counties' do
      tags %w[locations]
      http_codes [
        { code: 200, message: 'Counties list.' }
      ]
    end
    get 'counties' do
      counties_list = Location.counties.map { |county| { 'id' => county, 'name' => county } }

      present counties_list
    end
    # GET /locations
    desc 'Get available locations' do
      tags %w[locations]
      http_codes [
        { code: 200, message: 'Locations list.' },
        { code: 400, message: 'Bad request.' }
      ]
    end
    params do
      optional :county, type: String, desc: 'County name', documentation: { param_type: 'query' },
                        values: Location.counties
    end
    get do
      locations = if params[:county]
                    Location.where(county: params[:county]).map(&:to_s)
                  else
                    Location.all.map(&:to_s)
                  end

      locations_list = ((0...locations.size).zip locations)
                       .map { |location| { 'id' => location[0], 'name' => location[1] } }

      present locations_list
    end
  end
end
