require 'sidekiq'
require 'faraday'
require 'faraday/net_http'
Faraday.default_adapter = :net_http
require 'date'

require_relative '../models/weather'

# Wetter (Temperatur [durchschnitt, min und max], Sonnenaufgang, Sonnenuntergang,
# Niederschlagsmenge, Schnee, Regen, Wetterwarnungen, Sonnenstunden,
# Windgeschwindigkeit) jeweils aktuell und vorhersage (etwa 2-3 Tage)

class FetchWeather
  include Sidekiq::Job

  def perform(location, lat, lng)
    url = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=#{lat}&lon=#{lng}&cnt=5&units=metric&appid=#{ENV['OPEN_WEATHER_API_KEY']}"
    response = Faraday.get(url)
    data = JSON.parse(response.body)
    data['list'].each do |day|
      Weather.create(
        date: DateTime.strptime(day['dt'].to_s,'%s').to_date,
        location: location,
        temp: day['temp']['day'],
        temp_min: day['temp']['min'],
        temp_max: day['temp']['max'],
        sunrise: DateTime.strptime(day['sunrise'].to_s,'%s'),
        sunset: DateTime.strptime(day['sunset'].to_s,'%s'),
        rain: day['rain'],
        snow: day['snow'],
        weather: day['weather'][0]['main'],
        weather_description: day['weather'][0]['description'],
        weather_icon: day['weather'][0]['icon'],
        wind_speed: day['speed'],
        humidity: day['humidity']
      )
    end
  end
end
