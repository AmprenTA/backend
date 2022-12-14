# frozen_string_literal: true

class TransportationsApi < Grape::API
  format :json

  helpers AuthorizationHelper, CarbonFootprintHelper

  before do
    token = headers.fetch('Auth-Token', nil)
    authorize_user(token) if token
  end

  namespace 'transportations' do
    # POST /transportations
    desc 'Create transportations' do
      tags %w[transportations]
      http_codes [
        { code: 201, message: 'Transportation created.' },
        { code: 400, message: 'Bad request!' }
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

    params do
      requires :location, type: String, desc: 'Location', documentation: { param_type: 'body' }
      optional :flights, type: Array[JSON] do
        requires :from, type: String, desc: 'from', documentation: { param_type: 'body' }
        requires :to, type: String, desc: 'to', documentation: { param_type: 'body' }
      end
      optional :public_transports, type: Array[JSON] do
        requires :transport_type, type: Integer, desc: 'transport_type', documentation: { param_type: 'body' },
                                  values: PublicTransport.transport_types.values,
                                  default: PublicTransport.transport_types[:train]
        requires :total_km, type: Float, desc: 'km', documentation: { param_type: 'body' }, default: 0.0
      end
      optional :cars, type: Array[JSON] do
        requires :fuel_type, type: Integer, desc: 'fuel_type', documentation: { param_type: 'body' },
                             values: Car.fuel_types.values, default: Car.fuel_types[:diesel]
        requires :fuel_consumption, type: Float, desc: 'fuel_consumption', documentation: { param_type: 'body' },
                                    default: 0.0
        requires :total_km, type: Float, desc: 'total_km', documentation: { param_type: 'body' }, default: 0.0
      end
    end
    post do
      cars_params = params[:cars]
      flights_params = params[:flights]
      public_transports_params = params[:public_transports]
      location = params[:location]

      token = headers.fetch('Auth-Token', nil)
      if token
        user = authorize_user(token)
        footprint = Footprint.new(user_id: user.id, location:)
      else
        footprint = Footprint.new(location:)
      end
      error!(footprint.errors, 400) unless footprint&.save

      flights_params&.each do |flight_param|
        carbon_footprint = FlightDistance.where(
          from: [flight_param[:from], flight_param[:to]],
          to: [flight_param[:from], flight_param[:to]]
        ).first.carbon_footprint

        flight = Flight.new(
          from: flight_param[:from],
          to: flight_param[:to],
          footprint_id: footprint.id,
          carbon_footprint:
        )
        error!(flight.errors, 400) unless flight&.save
      end

      cars_params&.each do |car_param|
        carbon_footprint = CarFootprintCalculator.call(
          car_param[:total_km],
          car_param[:fuel_consumption],
          car_param[:fuel_type]
        )
        car = Car.new(
          fuel_type: car_param[:fuel_type],
          fuel_consumption: car_param[:fuel_consumption],
          total_km: car_param[:total_km],
          footprint_id: footprint.id,
          carbon_footprint:
        )
        error!(car.errors, 400) unless car&.save
      end

      public_transports_params&.each do |public_transport_param|
        carbon_footprint = PublicTransportFootprintCalculator.call(
          public_transport_param[:total_km],
          public_transport_param[:transport_type]
        )

        public_transport = PublicTransport.new(
          transport_type: public_transport_param[:transport_type],
          total_km: public_transport_param[:total_km],
          footprint_id: footprint.id,
          carbon_footprint:
        )
        error!(public_transport.errors, 400) unless public_transport&.save
      end

      transports = {
        cars_carbon_footprint: footprint.cars.map(&:carbon_footprint).sum,
        flights_carbon_footprint: footprint.flights.map(&:carbon_footprint).sum,
        public_transports_carbon_footprint: footprint.public_transports.map(&:carbon_footprint).sum,
        footprint_id: footprint.id
      }

      present transports
    end
  end
end
