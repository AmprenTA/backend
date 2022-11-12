# frozen_string_literal: true

class CarsApi < Grape::API
  resource :cars do
    # GET /cars
    desc 'Cars list' do
      tags %w[cars]
      http_codes [
        { code: 200, model: Entities::Car, message: 'Car list' }
      ]
    end
    get do
      cars = Car.all
      present cars, with: Entities::Car
    end

    # POST /cars
    desc 'Create car' do
      tags %w[cars]
      http_codes [
        { code: 201, model: Entities::Car, message: 'Car created' }
      ]
    end
    params do
      requires :fuel_type, type: Integer, desc: 'fuel_type', documentation: { param_type: 'body' }
      requires :total_km, type: Float, desc: 'total_km', documentation: { param_type: 'body' }
      optional :footprint_id, type: Integer, desc: 'footprint_id', documentation: { param_type: 'body' }
    end
    post do
      car = Car.new(
        fuel_type: params[:fuel_type],
        total_km: params[:total_km],
        footprint_id: params[:footprint_id]
      )
      error!(car.errors, 400) unless car.present? && car.save
      present car, with: Entities::Car
    end

    # GET /cars/:id
    route_param :id do
      desc 'Get car' do
        tags %w[cars]
        http_codes [
          { code: 200, model: Entities::Car, message: 'Car info' },
          { code: 404, message: 'Car not found!' }
        ]
      end
      params do
        requires :id, type: Integer
      end
      get do
        present Car.find(params[:id]), with: Entities::Car
      end
    end
  end
end
