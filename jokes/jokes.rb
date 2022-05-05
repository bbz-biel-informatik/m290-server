require_relative '../models/joke'
require 'cgi'

data = File.read('jokes/jokes.json')
jokes = JSON.parse(data)
jokes['value'].each do |joke|
  Joke.create(joke: CGI.unescapeHTML(joke['joke']), categories: joke['categories'].join(', '))
end
