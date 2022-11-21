# frozen_string_literal: true

class HousesApi < Grape::API
  helpers AuthorizationHelper

  resource :houses do
    # POST /houses
    desc 'Create house' do
      tags %w[houses]
      http_codes [
        { code: 201, model: Entities::House, message: 'House created' },
        { code: 400, model: Entities::House, message: 'Bad request!' }
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
      requires :electricity, type: Float, desc: 'electricity', documentation: { param_type: 'body' }
      requires :natural_gas, type: Float, desc: 'natural_gas', documentation: { param_type: 'body' }
      requires :wood, type: Float, desc: 'wood', documentation: { param_type: 'body' }
      requires :footprint_id, type: Integer, desc: 'footprint_id', documentation: { param_type: 'body' }
    end
    post do
      token = headers.fetch('Auth-Token', nil)
      authorize_user(token) if token
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
      error!(house.errors, 400) unless house.present? && house.save
      household_carbon_footprint = { carbon_footprint:, footprint_id: }
      present household_carbon_footprint
    end
  end
end
