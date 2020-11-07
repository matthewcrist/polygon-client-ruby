# frozen_string_literal: true

require 'polygon_client/rest/transport'

module PolygonClient
  # Polygon.io Reference REST API client.
  # @param [String] apiKey your polygon.io API key
  # @see https://polygon.io/docs/#getting-started
  class ReferenceClient
    def initialize(apiKey = nil)
      if apiKey.nil?
        raise PolygonClient::PolygonError,
              'Must supply a valid Polygon.io API key to ReferenceClient'
      end

      @apiKey = apiKey
    end

    def tickers(query)
      get('/v2/reference/tickers', query, @apiKey)
    end

    def ticker_types
      get('/v2/reference/types', {}, @apiKey)
    end

    def ticker_details(ticker)
      get("/v1/meta/symbols/#{ticker}/company", {}, @apiKey)
    end

    def ticker_news(ticker, query)
      get("/v1/meta/symbols/#{ticker}/news", query, @apiKey)
    end

    def markets
      get('/v2/reference/markets', {}, @apiKey)
    end

    def locales
      get('/v2/reference/locales', {}, @apiKey)
    end

    def stock_splits(ticker)
      get("/v2/reference/splits/#{ticker}", {}, @apiKey)
    end

    def stock_dividends(ticker)
      get("/v2/reference/dividends/#{ticker}", {}, @apiKey)
    end

    def stock_financials(ticker, query)
      get("/v2/reference/financials/#{ticker}", query, @apiKey)
    end

    def market_status
      get('/v1/marketstatus/now', {}, @apiKey)
    end

    def market_holidays
      get('/v1/marketstatus/upcoming', {}, @apiKey)
    end
  end
end
