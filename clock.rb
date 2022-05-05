require 'clockwork'
require_relative './jobs/fetch_weather'
require_relative './jobs/fetch_stock'
require_relative './jobs/fetch_crypto'
require_relative './jobs/fetch_commodity'
require_relative './jobs/fetch_tank'

THIRTY_MINUTES = 30 * 60

module Clockwork
  every(THIRTY_MINUTES, 'featch_weather_bern') { FetchWeather.perform_async('Bern', 46.9480, 7.4474) }
  every(THIRTY_MINUTES, 'featch_weather_belp') { FetchWeather.perform_async('Belp', 46.8914, 7.4990) }
  every(THIRTY_MINUTES, 'featch_weather_biel') { FetchWeather.perform_async('Biel', 47.1368, 7.2468) }
  every(THIRTY_MINUTES, 'featch_weather_barcelona') { FetchWeather.perform_async('Barcelona', 41.3874, 2.1686) }
  every(THIRTY_MINUTES, 'featch_weather_luzern') { FetchWeather.perform_async('Luzern', 47.0502, 8.3093) }
  every(THIRTY_MINUTES, 'featch_weather_huttwil') { FetchWeather.perform_async('Huttwil', 47.1134, 7.8515) }
  every(THIRTY_MINUTES, 'featch_weather_melchnau') { FetchWeather.perform_async('Melchnau', 47.1822, 7.8516) }
  every(THIRTY_MINUTES, 'featch_weather_thun') { FetchWeather.perform_async('Thun', 46.7580, 7.6280) }

  every(THIRTY_MINUTES, 'fetch_stock_ubs') { FetchStock.perform_async('UBS Group AG', 'UBS') }
  every(THIRTY_MINUTES, 'fetch_stock_cs') { FetchStock.perform_async('Credit Suisse Group AG', 'CS') }
  every(THIRTY_MINUTES, 'fetch_stock_raiffeisen') { FetchStock.perform_async('Raiffeisen Bank International AG', 'RAIFY') }
  every(THIRTY_MINUTES, 'fetch_stock_jpmorgan') { FetchStock.perform_async('JPMorgan Chase & Co.', 'JPM') }
  every(THIRTY_MINUTES, 'fetch_stock_boa') { FetchStock.perform_async('Bank of America', 'BAC') }
  # every(THIRTY_MINUTES, 'fetch_stock_zagreb') { FetchStock.perform_async('Zagrebacka Banka', '-') }
  # every(THIRTY_MINUTES, 'fetch_stock_pbz') { FetchStock.perform_async('Privredna Banka Zagreb', '-') }

  every(THIRTY_MINUTES, 'fetch_crypto_eth') { FetchCrypto.perform_async('Ethereum', 'ETH') }
  every(THIRTY_MINUTES, 'fetch_crypto_sol') { FetchCrypto.perform_async('Solana', 'SOL') }

  every(THIRTY_MINUTES, 'fetch_commodity_gold') { FetchCommodity.perform_async('Gold', 'ZGUSD') }
  every(THIRTY_MINUTES, 'fetch_commodity_oil') { FetchCommodity.perform_async('Rohöl', 'CLUSD') }
  every(THIRTY_MINUTES, 'fetch_commodity_gas') { FetchCommodity.perform_async('Erdgas', 'NGUSD') }
  every(THIRTY_MINUTES, 'fetch_commodity_benzin') { FetchCommodity.perform_async('Benzin', 'RBUSD') }

  every(THIRTY_MINUTES, 'fetch_tank') { FetchTank.perform_async }
end