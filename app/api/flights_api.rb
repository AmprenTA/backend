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
      requires :flights, type: Array[JSON], documentation: { param_type: 'body' } do
        requires :from, type: String, desc: 'from', documentation: { param_type: 'body' }
        requires :to, type: String, desc: 'to', documentation: { param_type: 'body' }
        requires :footprint_id, type: Integer, desc: 'footprint_id', documentation: { param_type: 'body' }
      end
    end
    post do
      flights = params[:flights]
      flights.each do |flight_param|
        flight = Flight.new(
          from: flight_param[:from],
          to: flight_param[:to],
          footprint_id: flight_param[:footprint_id]
        )
        error!(flight.errors, 400) unless flight.present? && flight.save
      end
      present flights
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
