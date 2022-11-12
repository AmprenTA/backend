# frozen_string_literal: true

class TransportationsApi < Grape::API
  format :json

  namespace 'transportation' do
    # POST /transportations
    desc 'Create transportation' do
      tags %w[transportation]
      http_codes [
        { code: 201, model: Entities::Transport, message: 'Create transportation' }
      ]
    end
    params do
      requires :cars, type: Array do
        requires :from, type: String, desc: 'from', documentation: { param_type: 'body' }
        requires :to, type: String, desc: 'to', documentation: { param_type: 'body' }
      end

      requires :public_transports, type: Array do
        requires :transport_type, type: Integer, desc: 'transport_type', documentation: { param_type: 'body' }
        requires :km, type: Float, desc: 'km', documentation: { param_type: 'body' }
      end

      requires :flights, type: Array do
        requires :fuel_type, type: Integer, desc: 'fuel_type', documentation: { param_type: 'body' }
        requires :total_km, type: Float, desc: 'total_km', documentation: { param_type: 'body' }
      end

      optional :footprint_id, type: Integer, desc: 'footprint_id', documentation: { param_type: 'body' }
    end
    post do
      car = Car.new(
        fuel_type: params[:fuel_type],
        total_km: params[:total_km],
        footprint_id: params[:footprint_id]
      )
      flight = Flight.new(
        from: params[:from],
        to: params[:to],
        footprint_id: params[:footprint_id]
      )
      public_transport = PublicTransport.new(
        transport_type: params[:transport_type],
        total_km: params[:km],
        footprint_id: params[:footprint_id]
      )
      error!(car.errors, 400) unless car.present? && car.save
      error!(flight.errors, 400) unless flight.present? && flight.save
      error!(public_transport.errors, 400) unless public_transport.present? && public_transport.save
      transport = {
        car:,
        flight:,
        public_transport:
      }
      present transport, with: Entities::Transport
    end
  end
end
