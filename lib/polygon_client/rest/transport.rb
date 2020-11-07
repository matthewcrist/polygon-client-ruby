# frozen_string_literal: true

require 'httparty'

POLYGON_API_URL = 'https://api.polygon.io'

def get(path, query, apiKey)
  auth_query = query.merge(apiKey: apiKey)
  HTTParty.get("#{POLYGON_API_URL}#{path}", query: auth_query)
end
