require 'sinatra/activerecord'

class Sensor < ActiveRecord::Base
  has_many :measurements
end
