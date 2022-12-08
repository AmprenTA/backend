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
    desc 'Average Footprints' do
      tags %w[statistics]
      http_codes [
        { code: 200, message: 'Average Footprints data.' }
      ]
    end
    params do
      optional :location, type: String, desc: 'Average Footprints', documentation: { param_type: 'query' }
    end
    get 'average_footprints' do
      avg_data = Statistics::AverageFootprint.call(params[:location])

      present avg_data
    end
    # TODO: Footprint for user per months
  end
end
