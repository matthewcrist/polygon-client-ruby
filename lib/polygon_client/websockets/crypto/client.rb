# frozen_string_literal: true

require 'event_emitter'
require 'websocket-client-simple'
require 'polygon_client/websockets/transport'

module PolygonClient
  # Polygon.io Crypto Websocket API client.
  # @param [String] apiKey your polygon.io API key
  # @see https://polygon.io/sockets
  class CryptoWebsocketClient
    include EventEmitter

    def initialize(apiKey = nil)
      if apiKey.nil?
        raise PolygonClient::PolygonError.new,
              'Must supply a valid Polygon.io API key'
      end

      @apiKey = apiKey

      connect
    end

    def connect
      @ws = WebSocket::Client::Simple.connect "#{POLYGON_WS_URL}/crypto"
      @ws.on :open do
        auth = { action: 'auth', params: @apiKey }
        @ws.send auth
      end

      @ws.on :message do |msg|
        emit :message, msg.data
      end
    end

    def subscribe(tickers)
      tickers_string = tickers.join(',')
      action = { action: 'subscribe', params: tickers_string }
      @ws.send action
    end

    def unsubscribe(tickers)
      tickers_string = tickers.join(',')
      action = { action: 'unsubscribe', params: tickers_string }
      @ws.send action
    end
  end
end
