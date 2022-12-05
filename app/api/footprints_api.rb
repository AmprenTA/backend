# frozen_string_literal: true

class FootprintsApi < Grape::API
  helpers AuthorizationHelper
  before do
    token = headers.fetch('auth_token', nil)
    authorize_user(token) if token
  end

  resource :footprints do
    route_param :id do
      # GET /footprints/:id
      desc 'Get footprint' do
        tags %w[footprints]
        http_codes [
          { code: 200, message: 'Footprint info.' },
          { code: 404, message: 'Footprint not found!' }
        ]
      end
      desc 'Headers', {
        headers: {
          'auth_token' => {
            description: 'Validates your identity',
            optional: true
          }
        }
      }

      get do
        cars_carbon_footprint = Footprint.find(params[:id]).cars.sum(&:carbon_footprint)
        public_transports_carbon_footprint = Footprint.find(params[:id]).public_transports.sum(&:carbon_footprint)
        flights_carbon_footprint = Footprint.find(params[:id]).flights.sum(&:carbon_footprint)
        house_carbon_footprint = Footprint.find(params[:id]).house.carbon_footprint
        avg_food_carbon_footprint = (Footprint.find(params[:id]).food.min_carbon_footprint +
                                 Footprint.find(params[:id]).food.max_carbon_footprint) / 2
        transportation_carbon_footprint = cars_carbon_footprint +
                                          flights_carbon_footprint +
                                          public_transports_carbon_footprint
        total_carbon_footprint = {
          transportation_carbon_footprint:,
          house_carbon_footprint:,
          food_carbon_footprint: {
            min: Footprint.find(params[:id]).food.min_carbon_footprint,
            max: Footprint.find(params[:id]).food.max_carbon_footprint,
            average: avg_food_carbon_footprint
          }
        }

        present total_carbon_footprint
      end
    end
  end
end
