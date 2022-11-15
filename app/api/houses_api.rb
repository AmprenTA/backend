# frozen_string_literal: true

class HousesApi < Grape::API
  resource :houses do
    # GET /houses
    desc 'Houses list' do
      tags %w[houses]
      http_codes [
        { code: 200, model: Entities::House, message: 'Houses list' }
      ]
    end
    get do
      house = House.all
      present house, with: Entities::House
    end

    # POST /houses
    desc 'Create house' do
      tags %w[houses]
      http_codes [
        { code: 201, model: Entities::House, message: 'House created' }
      ]
    end
    params do
      requires :electricity, type: Float, desc: 'electricity', documentation: { param_type: 'body' }
      requires :natural_gas, type: Float, desc: 'natural_gas', documentation: { param_type: 'body' }
      requires :wood, type: Float, desc: 'wood', documentation: { param_type: 'body' }
      requires :footprint_id, type: Integer, desc: 'footprint_id', documentation: { param_type: 'body' }
    end
    post do
      house = House.new(
        electricity: params[:electricity],
        natural_gas: params[:natural_gas],
        wood: params[:wood],
        footprint_id: params[:footprint_id]
      )
      unless house.present? && house.save
        error_msg = 'Bad Request'
        error!({ 'error_msg' => error_msg }, 400)
      end
      present house, with: Entities::House
    end

    # GET /houses/:id
    route_param :id do
      desc 'Get house' do
        tags %w[houses]
        http_codes [
          { code: 200, model: Entities::House, message: 'House info' },
          { code: 404, message: 'House not found!' }
        ]
      end
      params do
        requires :id, type: Integer
      end
      get do
        present House.find(params[:id]), with: Entities::House
      end
    end
  end
end
