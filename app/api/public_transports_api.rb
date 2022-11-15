# frozen_string_literal: true

class PublicTransportsApi < Grape::API
  before do
    :authentication
  end

  resource :public_transports do
    # GET /public_transports
    desc 'Public transports list' do
      tags %w[public_transports]
      http_codes [
        { code: 200, model: Entities::PublicTransport, message: 'Public transport list' }
      ]
    end
    get do
      public_transports = PublicTransport.all
      present public_transports, with: Entities::PublicTransport
    end

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

    # GET /public_transports/:id
    route_param :id do
      desc 'Get public transport' do
        tags %w[public_transports]
        http_codes [
          { code: 200, model: Entities::PublicTransport, message: 'Public transport info' },
          { code: 404, message: 'Public transports not found!' }
        ]
      end
      params do
        requires :id, type: Integer
      end
      get do
        present PublicTransport.find(params[:id]), with: Entities::PublicTransport
      end
    end
  end
end
