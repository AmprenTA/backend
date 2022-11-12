# frozen_string_literal: true

class FlightsApi < Grape::API
  format :json

  resource :flights do
    # GET /flights
    desc 'Flights list' do
      tags %w[flights]
      http_codes [
        { code: 200, model: Entities::Flight, message: 'Flight list' }
      ]
    end
    get do
      flights = Flight.all
      present flights, with: Entities::Flight
    end

    # POST /flights
    desc 'Create flight' do
      tags %w[flights]
      http_codes [
        { code: 201, model: Entities::Flight, message: 'Flight created' },
        { code: 401, model: Entities::User, message: 'Unauthorized!' },
        { code: 403, model: Entities::User, message: 'Forbidden!' }
      ]
    end
    params do
      requires :from, type: String, desc: 'from', documentation: { param_type: 'body' }
      requires :to, type: String, desc: 'to', documentation: { param_type: 'body' }
      requires :auth_token, type: String, desc: 'auth-token', documentation: { param_type: 'body' }
      optional :footprint_id, type: Integer, desc: 'footprint_id', documentation: { param_type: 'body' }
    end
    post do
      # TODO: ÎNTREBĂRI PENTRU DON PEDRO
      token = params['auth_token'] # SHOULD BE IN HEADERS!! GRAPE-SWAGGER HEADERS PARAMS???
      key = ENV.fetch('SECRET', nil)
      begin
        # TOKEN VERIFICATION
        decode_data = JWT.decode(token, key, true, { algorithm: 'HS256' })
        user_data = decode_data[0].values.first if decode_data
        # VERIFY USER
        user = User.find(user_data)
        # THROW ERROR IF USER TOKEN INVALID
        error!({ error: 'Unauthorized!' }, 401) unless user
        # USER VALID -> CREATE NEW FLIGHT
        flight = Flight.new(
          from: params[:from],
          to: params[:to],
          footprint_id: params[:footprint_id]
        )
        error!(flight.errors, 400) unless flight.present? && flight.save
        present flight, with: Entities::Flight
      rescue StandardError => e
        error!({ error: "Unauthorized! #{e}" }, 401)
      end
    end

    # GET /flights/:id
    route_param :id do
      desc 'Get flight' do
        tags %w[flights]
        http_codes [
          { code: 200, model: Entities::Flight, message: 'Flight info' },
          { code: 404, message: 'Flight not found!' }
        ]
      end
      params do
        requires :id, type: Integer
      end
      get do
        present Flight.find(params[:id])
      end
    end
  end
end
