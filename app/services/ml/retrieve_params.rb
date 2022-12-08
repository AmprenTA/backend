# frozen_string_literal: true

module Ml
  class RetrieveParams
    def initialize(endpoint_url)
      @endpoint_url = endpoint_url
    end

    def call
      body_response
    end

    def self.call(endpoint_url)
      new(endpoint_url).call
    end

    private

    attr_reader :endpoint_url

    def url
      URI(endpoint_url)
    end

    def net_http_initialize
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = false
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      http
    end

    def net_http_get_request
      http = net_http_initialize
      request = Net::HTTP::Get.new(url)
      http.request(request)
    end

    def body_response
      JSON.parse(net_http_get_request.body)
    end
  end
end
