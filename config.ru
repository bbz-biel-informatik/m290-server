require 'dotenv/load'
require 'rack/cors'
require './app'
require 'sidekiq'
require 'sidekiq/web'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :get
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == ENV["SIDEKIQ_USERNAME"] && password == ENV["SIDEKIQ_PASSWORD"]
end

use Rack::Session::Cookie, secret: ENV['SESSION_SECRET'], same_site: true, max_age: 86400

run Rack::URLMap.new('/' => M290, '/sidekiq' => Sidekiq::Web)
