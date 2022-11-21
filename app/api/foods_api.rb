# frozen_string_literal: true

class FoodsApi < Grape::API
  helpers AuthorizationHelper

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
      requires :beef, type: Integer, desc: 'beef', documentation: { param_type: 'body' }
      requires :lamb, type: Integer, desc: 'lamb', documentation: { param_type: 'body' }
      requires :poultry, type: Integer, desc: 'poultry', documentation: { param_type: 'body' }
      requires :pork, type: Integer, desc: 'pork', documentation: { param_type: 'body' }
      requires :fish, type: Integer, desc: 'fish', documentation: { param_type: 'body' }
      requires :milk_based, type: Integer, desc: 'milk_based', documentation: { param_type: 'body' }
      requires :cheese, type: Integer, desc: 'cheese', documentation: { param_type: 'body' }
      requires :eggs, type: Integer, desc: 'eggs', documentation: { param_type: 'body' }
      requires :coffee, type: Integer, desc: 'coffee', documentation: { param_type: 'body' }
      requires :vegetables, type: Integer, desc: 'vegetables', documentation: { param_type: 'body' }
      requires :bread, type: Integer, desc: 'bread', documentation: { param_type: 'body' }
      requires :footprint_id, type: Integer, desc: 'footprint_id', documentation: { param_type: 'body' }
    end

    post do
      token = headers.fetch('auth_token', nil)
      authorize_user(token) if token

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
