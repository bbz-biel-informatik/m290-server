require 'sidekiq'
require 'faraday'
require 'faraday/net_http'
Faraday.default_adapter = :net_http
require 'date'

require_relative '../models/stock'

class FetchStock
  include Sidekiq::Job

  def perform(name, symbol)
    url = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{symbol}&apikey=#{ENV['ALPHA_VANTAGE_API_KEY']}"
    response = Faraday.get(url)
    data = JSON.parse(response.body)
    Stock.create!(
      name: name,
      symbol: symbol,
      price: data['Global Quote']['05. price']
    )
  end
end
