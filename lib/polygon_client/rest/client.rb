# frozen_string_literal: true

require 'polygon_client/rest/reference/client'
require 'polygon_client/rest/stocks/client'
require 'polygon_client/rest/forex/client'
require 'polygon_client/rest/crypto/client'

module PolygonClient
  # Top-level Polygon.io REST API client.
  # @param [String] apiKey your polygon.io API key
  # @see https://polygon.io/docs/#getting-started
  class RestClient
    def initialize(apiKey = nil)
      if apiKey.nil?
        raise PolygonClient::PolygonError,
              'Must supply a valid Polygon.io API key to RestClient'
      end

      @apiKey = apiKey

      @reference = ReferenceClient.new(apiKey)
      @stocks = StocksClient.new(apiKey)
      @forex = ForexClient.new(apiKey, @stocks)
      @crypto = CryptoClient.new(apiKey, @stocks)
    end

    attr_reader :reference
    attr_reader :stocks
    attr_reader :forex
    attr_reader :crypto
  end
end
