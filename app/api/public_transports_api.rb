# frozen_string_literal: true

class PublicTransportsApi < Grape::API
  resource :public_transports do
    # POST /public_transports
    desc 'Create public transport' do
      tags %w[public_transports]
      http_codes [
        { code: 201, model: Entities::PublicTransport, message: 'Public transport created' }
      ]
    end
    params do
      requires :transport_type, type: Integer, desc: 'transport_type', documentation: { param_type: 'body' }
      requires :total_km, type: Float, desc: 'total_km', documentation: { param_type: 'body' }
      requires :footprint_id, type: Integer, desc: 'footprint_id', documentation: { param_type: 'body' }
    end
    post do
      public_transport = PublicTransport.new(
        transport_type: params[:transport_type],
        total_km: params[:total_km],
        footprint_id: params[:footprint_id]
      )
      error!(public_transport.errors, 400) unless public_transport.present? && public_transport.save
      present public_transport, with: Entities::PublicTransport
    end
  end
end
