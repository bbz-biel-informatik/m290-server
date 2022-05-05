require 'sidekiq'
require 'date'
require 'nokogiri'
require 'open-uri'

require_relative '../models/water'

class FetchWater
  include Sidekiq::Job

  def perform(name, station_id)
    doc = Nokogiri::HTML(URI.open("https://www.hydrodaten.admin.ch/de/#{station_id}.html"))
    tables = doc.css('table')
    table = tables.first
    flow = table.css('th, td')[5].text.to_f
    level = table.css('th, td')[6].text.to_f
    temperature = table.css('th, td')[7].text.to_f
    Water.create!(name: name, flow: flow, level: level, temperature: temperature)
  end
end
