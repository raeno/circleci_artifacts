require 'sinatra'
require_relative './artifacts_fetcher'
configure { set :server, :puma }
user = ENV['username']
project = ENV['project']
token = ENV['token']

get '/shield/:branch' do
  branch = params[:branch]
  fetcher = ArtifactsFetcher.new user,project, token
  shield_url = fetcher.coverage_shield_url branch
  redirect shield_url
end
