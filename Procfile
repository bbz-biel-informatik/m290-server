web: bundle exec rackup config.ru -p $PORT
clock: bundle exec clockwork clock.rb
worker: bundle exec sidekiq -r ./jobs/main.rb
