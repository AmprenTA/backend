# frozen_string_literal: true

class FoodsApi < Grape::API
  helpers AuthorizationHelper

  resource :foods do
    # POST /foods
    desc 'Create foods' do
      tags %w[foods]
      http_codes [
        { code: 201, message: 'Create foods' },
        { code: 400, message: 'Bad request!' }
      ]
    end
    desc 'Headers', {
      headers: {
        'Auth-Token' => {
          description: 'Validates your identity',
          optional: true
        }
      }
    }
    params do
      requires :beef, type: Array[Integer], desc: 'beef', documentation: { param_type: 'body' }
      requires :lamb, type: Array[Integer], desc: 'lamb', documentation: { param_type: 'body' }
      requires :poultry, type: Array[Integer], desc: 'poultry', documentation: { param_type: 'body' }
      requires :pork, type: Array[Integer], desc: 'pork', documentation: { param_type: 'body' }
      requires :fish, type: Array[Integer], desc: 'fish', documentation: { param_type: 'body' }
      requires :milk_based, type: Array[Integer], desc: 'milk_based', documentation: { param_type: 'body' }
      requires :cheese, type: Array[Integer], desc: 'cheese', documentation: { param_type: 'body' }
      requires :eggs, type: Array[Integer], desc: 'eggs', documentation: { param_type: 'body' }
      requires :coffee, type: Array[Integer], desc: 'coffee', documentation: { param_type: 'body' }
      requires :vegetables, type: Array[Integer], desc: 'vegetables', documentation: { param_type: 'body' }
      requires :bread, type: Array[Integer], desc: 'bread', documentation: { param_type: 'body' }
      requires :footprint_id, type: Integer, desc: 'footprint_id', documentation: { param_type: 'body' }
    end
    post do
      token = headers.fetch('Auth-Token', nil)
      authorize_user(token) if token
      min_max_carbon_footprint = FoodFootprintCalculator.new(params).call
      footprint_id = params[:footprint_id]
      food = Food.new(
        min_carbon_footprint: min_max_carbon_footprint[0],
        max_carbon_footprint: min_max_carbon_footprint[1],
        footprint_id:
      )
      error!(food.errors, 400) unless food.present? && food.save
      food_carbon_footprint = { min_max_carbon_footprint:, footprint_id: }
      present food_carbon_footprint
    end
  end
end
