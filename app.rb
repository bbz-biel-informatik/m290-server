require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'logger'
require 'dotenv/load'
require 'securerandom'

Dir.glob("models/*.rb").each do |f|
  require_relative f
end

class M290 < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure :development do
    register Sinatra::Reloader
    also_reload "models/*.rb"
  end

  configure :development, :production do
    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG if development?
    set :logger, logger
  end

  post '/measurements' do
    request.body.rewind
    payload = JSON.parse(request.body.read)
    puts payload.inspect
    sensor = Sensor.find_or_create_by(mac_address: payload['mac_address'])

    measurement = sensor.measurements.create(
      temperature: payload['temperature'],
      humidity: payload['humidity'],
      soil_moisture: payload['soil_moisture']
    )
    if measurement.valid?
      status 201
      body "Created measurement with id #{measurement.id}"
    else
      status 400
      body "Invalid measurement: #{measurement.errors.full_messages.join(', ')}"
    end
  end

  get '/measurements' do
    measurements = Measurement.all
    if measurements.empty?
      status 204
      body ''
    else
      status 200
      content_type 'application/json'
      body measurements.to_json
    end
  end

  get '/sensors' do
    sensors = Sensor.all
    if sensors.empty?
      status 204
      body ''
    else
      status 200
      content_type 'application/json'
      body sensors.to_json
    end
  end
end
