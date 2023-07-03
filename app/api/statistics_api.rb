# frozen_string_literal: true

class StatisticsApi < Grape::API
  format :json
  helpers AuthorizationHelper

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

    # /statistics/city_emissions
    desc 'Average CO2 emissions per city' do
      tags %w[statistics]
      http_codes [
        { code: 200, message: 'Average city emissions.' }
      ]
    end
    params do
      optional :location, type: String, desc: 'City', documentation: { param_type: 'query' }
    end
    get 'city_emissions' do
      city_emissions = Statistics::CityEmissions.call(params[:location])

      present city_emissions
    end

    # /statistics/country_emissions
    desc 'Average CO2 emissions per country' do
      tags %w[statistics]
      http_codes [
        { code: 200, message: 'Average country emissions.' }
      ]
    end
    get 'country_emissions' do
      country_emissions = Statistics::CountryEmissions.call

      present country_emissions
    end

    # /statistics/city_graphs
    desc 'Emissions graphs for a city' do
      tags %w[statistics]
      http_codes [
        { code: 200, message: 'Emissions graphs for a city.' }
      ]
    end
    params do
      requires :location, type: String, desc: 'City', documentation: { param_type: 'query' }
    end
    get 'city_graphs' do
      city_graphs = Statistics::CityGraphs.call(params[:location])

      present city_graphs
    end

    # /statistics/country_graphs
    desc 'Emissions graphs for a country' do
      tags %w[statistics]
      http_codes [
        { code: 200, message: 'Emissions graphs for a country.' }
      ]
    end
    get 'country_graphs' do
      country_graphs = Statistics::CountryGraphs.call

      present country_graphs
    end

    # /statistics/personal_graphs
    desc 'Emissions graphs for an individual' do
      tags %w[statistics]
      http_codes [
        { code: 200, message: 'Emissions graphs for an individual.' }
      ]
    end
    get 'personal_graphs' do
      token = headers.fetch('Auth-Token', nil)
      user = authorize_user(token) if token
      personal_graphs = Statistics::PersonalGraphs.call(user)

      present personal_graphs
    end
  end
end
