require 'uri'
require "sinatra/activerecord/rake"

namespace :db do
  task :load_config do
    require "./app"
  end
end

task :console do
  require 'irb'
  require './app'
  ARGV.clear
  IRB.start
end
