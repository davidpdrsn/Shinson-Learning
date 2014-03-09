# this is just server that searches google and returns the first 10 results as json
# used for testing
# install dependencies with `bundle install`
# and start the server with `cd examples && ruby server.rb`
# then point your browser to http://localhost:4567/basic.html
# or one of the other example html files

require 'sinatra'
require 'google-search'
require 'json'

get '/' do
  Dir.glob("*.html").inject("") do |html, html_file|
    html += "<a href='#{html_file}'>#{html_file.sub(".html", "")}</a><br>"
  end
end

get '/*.html' do
  send_file params[:splat].first + '.html'
end

get '/jquery.sayt.js' do
  send_file '../jquery.sayt.js'
end

get '/ajax' do
  results = Google::Search::Web.new(query: params[:query]).all_items[1..10].map do |result|
    { url: result.uri, text: result.title }
  end.to_json
end

post '/ajax' do
  results = Google::Search::Web.new(query: params[:query]).all_items[1..10].map do |result|
    { url: result.uri, text: result.title }
  end.to_json
end
