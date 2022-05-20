require 'sidekiq'
require 'faraday'
require 'faraday/net_http'
Faraday.default_adapter = :net_http
require 'date'
require 'mini_magick'

require_relative '../models/sky_color'

class FetchSkyColor
  include Sidekiq::Job

  HALF_HOUR = 30 * 60

  def perform(location, id, token, range)
    # https://vcdn.bergfex.at/webcams/archive.new/downsized/0/10990/2022/05/12/10990_2022-05-12_1400_688d47e0ed941b8b.jpg
    url = "https://vcdn.bergfex.at/webcams/archive.new/downsized/0/%ID%/%YEAR%/%MONTH%/%DAY%/%ID%_%YEAR%-%MONTH%-%DAY%_%HOUR%%MINUTE%_%TOKEN%.jpg"
    time = Time.current - HALF_HOUR
    time = Time.at((time.to_f / HALF_HOUR).floor * HALF_HOUR)
    url = url.gsub(/%YEAR%/, time.year.to_s)
    url = url.gsub(/%MONTH%/, time.month.to_s.rjust(2, '0'))
    url = url.gsub(/%DAY%/, time.day.to_s.rjust(2, '0'))
    url = url.gsub(/%HOUR%/, time.hour.to_s.rjust(2, '0'))
    url = url.gsub(/%MINUTE%/, time.min.to_s.rjust(2, '0'))
    url = url.gsub(/%ID%/, id.to_s)
    url = url.gsub(/%TOKEN%/, token.to_s)
    image = MiniMagick::Image.open(url)
    pixels = image.get_pixels
    colors = []
    puts "#{image.width}x#{image.height}"
    puts range.inspect
    (range[:min_x]..range[:max_x]).step(100).each do |x|
      (range[:min_y]..range[:max_y]).step(100).each do |y|
        colors << pixels[y][x]
      end
    end
    r = colors.map{|x| x[0]}.inject(:+) / colors.size
    g = colors.map{|x| x[1]}.inject(:+) / colors.size
    b = colors.map{|x| x[2]}.inject(:+) / colors.size
    SkyColor.create!(location: location, r: r, g: g, b: b)
  end
end

=begin
SOLL: https://vcdn.bergfex.at/webcams/archive.new/downsized/0/10990/2022/05/15/10990_2022-05-15_1700_688d47e0ed941b8b.jpg
IST:  https://vcdn.bergfex.at/webcams/archive.new/downsized/0/10990/2017/06/10/10990_2017-06-10_1700_688d47e0ed941b8b.jpg
IST2: https://vcdn.bergfex.at/webcams/archive.new/downsized/0/10990/2022/05/15/10990_2022-05-15_2000_688d47e0ed941b8b.jpg
=end
