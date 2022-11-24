# frozen_string_literal: true

class FlightsApi < Grape::API
  format :json
  resource :flights do
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

    namespace 'airports' do
      # POST /flights/airports
      desc 'Get available airports' do
        tags %w[flights]
        http_codes [
          { code: 200, message: 'Airports list' }
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
