# frozen_string_literal: true

require 'rack/cors'
require_relative 'config/environment'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: %i[get post]
  end
end

run Rails.application
Rails.application.load_server
