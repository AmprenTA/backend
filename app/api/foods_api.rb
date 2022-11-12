# frozen_string_literal: true

class FoodsApi < Grape::API
  resource :foods do
    # GET /foods
    desc 'Food list' do
      tags %w[foods]
      http_codes [
        { code: 200, model: Entities::Food, message: 'Food list' }
      ]
    end
    get do
      foods = Food.all
      present foods, with: Entities::Food
    end

    # GET /foods/:id
    route_param :id do
      desc 'Get food' do
        tags %w[foods]
        http_codes [
          { code: 200, model: Entities::Food, message: 'Food info' },
          { code: 404, message: 'Food not found!' }
        ]
      end
      params do
        requires :id, type: Integer
      end
      get do
        present Food.find(params[:id]), with: Entities::Food
      end
    end
  end
end
