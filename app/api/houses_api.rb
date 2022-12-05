# frozen_string_literal: true

class HousesApi < Grape::API
  helpers AuthorizationHelper
  before do
    token = headers.fetch('auth_token', nil)
    authorize_user(token) if token
  end

  resource :houses do
    # POST /houses
    desc 'Create house' do
      tags %w[houses]
      http_codes [
        { code: 201, model: Entities::House, message: 'House created.' },
        { code: 400, model: Entities::House, message: 'Bad request!' }
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
      requires :electricity, type: Float, desc: 'electricity', documentation: { param_type: 'body' }, default: 0.0
      requires :natural_gas, type: Float, desc: 'natural_gas', documentation: { param_type: 'body' }, default: 0.0
      requires :wood, type: Float, desc: 'wood', documentation: { param_type: 'body' }, default: 0.0
      requires :footprint_id, type: Integer, desc: 'footprint_id', documentation: { param_type: 'body' }
    end
    post do
      carbon_footprint = HouseholdFootprintCalculator.new(params[:electricity],
                                                          params[:natural_gas],
                                                          params[:wood]).call
      footprint_id = params[:footprint_id]
      house = House.new(
        electricity: params[:electricity],
        natural_gas: params[:natural_gas],
        wood: params[:wood],
        carbon_footprint:,
        footprint_id:
      )
      error!(house.errors, 400) unless house&.save

      household_carbon_footprint = { carbon_footprint:, footprint_id: }

      present household_carbon_footprint
    end
  end
end
