# frozen_string_literal: true

require 'polygon_client/rest/transport'

module PolygonClient
  # Polygon.io Stocks REST API client.
  # @param [String] apiKey your polygon.io API key
  # @see https://polygon.io/docs/#getting-started
  class StocksClient
    def initialize(apiKey = nil)
      if apiKey.nil?
        raise PolygonClient::PolygonError.new,
              'Must supply a valid Polygon.io API key to ReferenceClient'
      end

      @apiKey = apiKey
    end

    def exchanges
      test = get('/v1/meta/exchanges', {}, @apiKey)
      puts test.to_yaml
    end

    def historic_trades(ticker, date, query)
      get("/v2/ticks/stocks/trades/#{ticker}/#{date}", query, @apiKey)
    end

    def historic_quotes(ticker, date, query)
      get("/v2/ticks/stocks/nbbo/#{ticker}/#{date}", query, @apiKey)
    end

    def last_trade_for_symbol(ticker)
      get("/v1/last/stocks/#{ticker}", {}, @apiKey)
    end

    def last_quote_for_symbol(ticker)
      get("/v1/last_quote/stocks/#{ticker}", {}, @apiKey)
    end

    def daily_open_close(ticker, date)
      get("/v1/open-close/#{ticker}/#{date}", {}, @apiKey)
    end

    def condition_mappings(ticktype = 'trades')
      get("/v1/meta/conditions/#{ticktype}", {}, @apiKey)
    end

    def snapshot_all_tickers
      get('/v2/snapshot/locale/us/markets/stocks/tickers', {}, @apiKey)
    end

    def snapshot_single_ticker(ticker)
      get(
        "/v2/snapshot/locale/us/markets/stocks/tickers/#{ticker}",
        {},
        @apiKey
      )
    end

    def snapshot_gainers_losers(direction = 'gainers')
      get(
        "/v2/snapshot/locale/us/markets/stocks/#{direction}",
        {},
        @apiKey
      )
    end

    def previous_close(ticker, query)
      get("/v2/aggs/ticker/#{ticker}/prev", query, @apiKey)
    end

    def aggregates(ticker, multiplier, timespan, from, to, query)
      get(
        "/v2/aggs/ticker/#{ticker}" \
        "/range/#{multiplier}/#{timespan}/#{from}/#{to}",
        query,
        @apiKey
      )
    end

    def grouped_daily(locale, market, date, query)
      get(
        "/v2/aggs/grouped/locale/#{locale}/market/#{market}/#{date}",
        query,
        @apiKey
      )
    end
  end
end
