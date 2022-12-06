# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'openssl'

class LocationsCall
  def initialize(endpoint_url)
    @endpoint_url = endpoint_url
  end

  def self.call(endpoint_url)
    new(endpoint_url).call
  end

  def call
    net_http_call
  end

  private

  attr_reader :endpoint_url

  def net_http_call
    url = URI(endpoint_url)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    response = http.request(request)

    JSON.parse(response.body)
  end
end
