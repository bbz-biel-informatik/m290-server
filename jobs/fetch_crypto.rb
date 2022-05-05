require 'sidekiq'
require 'faraday'
require 'faraday/net_http'
Faraday.default_adapter = :net_http
require 'date'

require_relative '../models/crypto'

class FetchCrypto
  include Sidekiq::Job

  def perform(name, symbol)
    url = "https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=#{symbol}&to_currency=CHF&apikey=#{ENV['ALPHA_VANTAGE_API_KEY']}"
    response = Faraday.get(url)
    data = JSON.parse(response.body)
    Crypto.create!(
      name: name,
      symbol: symbol,
      price: data['Realtime Currency Exchange Rate']['5. Exchange Rate']
    )
  end
end
