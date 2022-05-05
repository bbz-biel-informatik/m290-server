require 'sidekiq'
require 'faraday'
require 'faraday/net_http'
Faraday.default_adapter = :net_http
require 'date'

require_relative '../models/commodity'

class FetchTank
  include Sidekiq::Job

  def perform()
    url = "https://creativecommons.tankerkoenig.de/json/prices.php?ids=4429a7d9-fb2d-4c29-8cfe-2ca90323f9f8&apikey=#{ENV['TANKERKOENIG_API_KEY']}"
    response = Faraday.get(url)
    data = JSON.parse(response.body)
    Commodity.create!(
      name: 'Benzin E10',
      symbol: 'E10',
      price: data['prices']['4429a7d9-fb2d-4c29-8cfe-2ca90323f9f8']['e10']
    )
    Commodity.create!(
      name: 'Benzin E5',
      symbol: 'E5',
      price: data['prices']['4429a7d9-fb2d-4c29-8cfe-2ca90323f9f8']['e5']
    )
    Commodity.create!(
      name: 'Diesel',
      symbol: 'DIESEL',
      price: data['prices']['4429a7d9-fb2d-4c29-8cfe-2ca90323f9f8']['diesel']
    )
  end
end
