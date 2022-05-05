require 'sidekiq'
require 'faraday'
require 'faraday/net_http'
Faraday.default_adapter = :net_http
require 'date'

require_relative '../models/commodity'

class FetchCommodity
  include Sidekiq::Job

  def perform(name, symbol)
    url = "https://financialmodelingprep.com/api/v3/historical-chart/1min/#{symbol}?apikey=#{ENV['FMP_API_KEY']}"
    response = Faraday.get(url)
    data = JSON.parse(response.body)
    Commodity.create!(
      name: name,
      symbol: symbol,
      price: data.first['close']
    )
  end
end
