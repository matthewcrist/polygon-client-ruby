# frozen_string_literal: true

require 'polygon_client/rest/transport'

module PolygonClient
  # Polygon.io Forex REST API client.
  # @param [String] apiKey your polygon.io API key
  # @see https://polygon.io/docs/#getting-started
  class ForexClient
    def initialize(apiKey = nil, stocks_client = nil)
      if apiKey.nil?
        raise PolygonClient::PolygonError.new,
              'Must supply a valid Polygon.io API key to ReferenceClient'
      end

      @stocks_client = stocks_client

      if @stocks_client.nil?
        @stocks_client = PolygonClient::StocksClient.new(apiKey)
      end

      @apiKey = apiKey
    end

    def previous_close(ticker, query)
      @stocks_client.previous_close(ticker, query)
    end

    def aggregates(ticker, multiplier, timespan, from, to, query)
      @stocks_client.aggregates(ticker, multiplier, timespan, from, to, query)
    end

    def grouped_daily(locale, market, date, query)
      @stocks_client.grouped_daily(locale, market, date, query)
    end

    def historic_forex_ticks(from, to, date, query)
      get("/v1/historic/forex/#{from}/#{to}/#{date}", query, @apiKey)
    end

    def real_time_currency_conversion(from, to, query)
      get("/v1/conversion/#{from}/#{to}", query, @apiKey)
    end

    def last_quote_for_currency_pair(from, to)
      get("/v1/last_quote/currencies/#{from}/#{to}", {}, @apiKey)
    end

    def snapshot_all_tickers
      get('/v2/snapshot/locale/global/markets/forex/tickers', {}, @apiKey)
    end

    def snapshot_gainers_losers(direction = 'gainers')
      get("/v2/snapshot/locale/global/markets/forex/#{direction}", {}, @apiKey)
    end
  end
end
