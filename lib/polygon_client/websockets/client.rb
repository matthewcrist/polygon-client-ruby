# frozen_string_literal: true

require 'polygon_client/websockets/stocks/client'
require 'polygon_client/websockets/forex/client'
require 'polygon_client/websockets/crypto/client'

module PolygonClient
  # Top-level Polygon.io Websocket API client.
  # @param [String] apiKey your polygon.io API key
  # @see https://polygon.io/sockets
  class WebsocketClient
    def initialize(apiKey = nil)
      if apiKey.nil?
        raise PolygonClient::PolygonError.new,
              'Must supply a valid Polygon.io API key'
      end

      @apiKey = apiKey

      @stocks = PolygonClient::StocksWebsocketClient.new(apiKey)
      @forex = PolygonClient::ForexWebsocketClient.new(apiKey)
      @crypto = PolygonClient::CryptoWebsocketClient.new(apiKey)
    end

    attr_reader :stocks
    attr_reader :forex
    attr_reader :crypto
  end
end
