# frozen_string_literal: true

class TransportationsApi < Grape::API
  format :json

  namespace 'transportation' do
    # POST /transportations
    desc 'Create transportation' do
      tags %w[transportation]
      http_codes [
        { code: 201, message: 'Create transportation' },
        { code: 400, message: 'Bad request!' }
      ]
    end
    params do
      requires :flights, type: Array[JSON] do
        requires :from, type: String, desc: 'from', documentation: { param_type: 'body' }
        requires :to, type: String, desc: 'to', documentation: { param_type: 'body' }
      end
      requires :public_transports, type: Array[JSON] do
        requires :transport_type, type: Integer, desc: 'transport_type', documentation: { param_type: 'body' }
        requires :total_km, type: Float, desc: 'km', documentation: { param_type: 'body' }
      end
      requires :cars, type: Array[JSON] do
        requires :fuel_type, type: Integer, desc: 'fuel_type', documentation: { param_type: 'body' }
        requires :fuel_consumption, type: Float, desc: 'fuel_consumption', documentation: { param_type: 'body' }
        requires :total_km, type: Float, desc: 'total_km', documentation: { param_type: 'body' }
      end
      requires :footprint_id, type: Integer, desc: 'footprint_id', documentation: { param_type: 'body' }
    end
    post do
      cars_params = params[:cars]
      flights_params = params[:flights]
      public_transports_params = params[:public_transports]
      footprint_id = params[:footprint_id]
      # TODO: Call CO2 calculator on each object creation

      flights_params.each do |flight_param|
        flight = Flight.new(
          from: flight_param[:from],
          to: flight_param[:to],
          footprint_id:,
          carbon_footprint: 0.0
        )
        error!(flight.errors, 400) unless flight.present? && flight.save
      end

      cars_params.each do |car_param|
        car = Car.new(
          fuel_type: car_param[:fuel_type],
          fuel_consumption: car_param[:fuel_consumption],
          total_km: car_param[:total_km],
          footprint_id:,
          carbon_footprint: 0.0
        )
        error!(car.errors, 400) unless car.present? && car.save
      end

      public_transports_params.each do |public_transport_param|
        public_transport = PublicTransport.new(
          transport_type: public_transport_param[:transport_type],
          total_km: public_transport_param[:total_km],
          footprint_id:,
          carbon_footprint: 0.0
        )
        error!(public_transport.errors, 400) unless public_transport.present? && public_transport.save
      end

      # TODO: Extract service to calculate the CO2 footprint for each object
      transports = {
        cars: 'Carbon footprint for cars',
        flights: 'Carbon footprint for flights',
        public_transports: 'Carbon footprint for public transports'
      }

      present transports
    end
  end
end
