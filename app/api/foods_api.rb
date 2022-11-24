# frozen_string_literal: true

class FoodsApi < Grape::API
  helpers AuthorizationHelper
  before do
    token = headers.fetch('auth_token', nil)
    authorize_user(token) if token
  end

  resource :foods do
    # POST /foods
    desc 'Create foods' do
      tags %w[foods]
      http_codes [
        { code: 201, message: 'Foods created!' },
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
      requires :beef, type: Integer, desc: 'beef', documentation: { param_type: 'body' },
                      values: [0, 1, 2, 3, 4], default: 0
      requires :lamb, type: Integer, desc: 'lamb', documentation: { param_type: 'body' },
                      values: [0, 1, 2, 3, 4], default: 0
      requires :poultry, type: Integer, desc: 'poultry', documentation: { param_type: 'body' },
                         values: [0, 1, 2, 3, 4], default: 0
      requires :pork, type: Integer, desc: 'pork', documentation: { param_type: 'body' },
                      values: [0, 1, 2, 3, 4], default: 0
      requires :fish, type: Integer, desc: 'fish', documentation: { param_type: 'body' },
                      values: [0, 1, 2, 3, 4], default: 0
      requires :milk_based, type: Integer, desc: 'milk_based', documentation: { param_type: 'body' },
                            values: [0, 1, 2, 3, 4], default: 0
      requires :cheese, type: Integer, desc: 'cheese', documentation: { param_type: 'body' },
                        values: [0, 1, 2, 3, 4], default: 0
      requires :eggs, type: Integer, desc: 'eggs', documentation: { param_type: 'body' },
                      values: [0, 1, 2, 3, 4], default: 0
      requires :coffee, type: Integer, desc: 'coffee', documentation: { param_type: 'body' },
                        values: [0, 1, 2, 3, 4], default: 0
      requires :vegetables, type: Integer, desc: 'vegetables', documentation: { param_type: 'body' },
                            values: [0, 1, 2, 3, 4], default: 0
      requires :bread, type: Integer, desc: 'bread', documentation: { param_type: 'body' },
                       values: [0, 1, 2, 3, 4], default: 0
      requires :footprint_id, type: Integer, desc: 'footprint_id', documentation: { param_type: 'body' }, default: 1
    end

    post do
      min_max_carbon_footprint = FoodFootprintCalculator.call(params)
      footprint_id = params[:footprint_id]

      food = Food.new(
        min_carbon_footprint: min_max_carbon_footprint[0],
        max_carbon_footprint: min_max_carbon_footprint[1],
        footprint_id:
      )
      error!(food.errors, 400) unless food&.save

      food_carbon_footprint = {
        min_carbon_footprint: min_max_carbon_footprint[0],
        max_carbon_footprint: min_max_carbon_footprint[1],
        footprint_id:
      }

      present food_carbon_footprint
    end
  end
end
