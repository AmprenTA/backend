# frozen_string_literal: true

class RootApi < Grape::API
  format :json

  rescue_from ActiveRecord::RecordNotFound do
    error!('Not Found', 404)
  end

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    rack_response({
      status: e.status,
      error_msg: e.message
    }.to_json, 400)
  end

  mount FoodsApi
  mount FootprintsApi
  mount FlightsApi
  mount HousesApi
  mount LocationsApi
  mount TransportationsApi
  mount UsersApi

  add_swagger_documentation(
    format: :json,
    base_path: '/api/v1',
    mount_path: 'docs',
    info: { title: 'API docs' },
    models: [],
    array_use_braces: true,
    add_root: true
  )
end
