# frozen_string_literal: true

require 'polygon_client/version'
require 'polygon_client/rest/client'
require 'polygon_client/websockets/client'

module PolygonClient
  class PolygonError < StandardError; end

  # Top-level Polygon.io API client.
  # @param [String] apiKey your polygon.io API key
  # @see https://polygon.io/docs/#getting-started
  class Client
    def initialize(apiKey = nil)
      if apiKey.nil?
        raise PolygonClient::PolygonError.new,
              'Must supply a valid Polygon.io API key'
      end

      @rest = PolygonClient::RestClient.new(apiKey)
      # @websockets = PolygonClient::WebsocketClient.new(apiKey)
    end

    attr_reader :rest
  end
end
