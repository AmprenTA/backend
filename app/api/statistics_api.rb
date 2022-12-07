# frozen_string_literal: true

class StatisticsApi < Grape::API
  format :json

  resource :statistics do
    desc 'Get ML data' do
      tags %w[statistics]
      http_codes [
        { code: 200, message: 'Regression data.' }
      ]
    end
    params do
      requires :total_footprints, type: Integer, desc: 'Total Footprints', documentation: { param_type: 'query' }
    end
    get 'regression_model' do
      plot_data = Ml::ComputeData.call(params[:total_footprints])

      present plot_data
    end

    # TODO: Footprint(transportations, house, food) for specific town, month,
    # TODO: Footprint for user per months
  end
end
