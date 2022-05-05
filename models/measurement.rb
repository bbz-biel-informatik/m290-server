require 'sinatra/activerecord'

class Measurement < ActiveRecord::Base
  belongs_to :sensor
end
