require 'rubygems'


ENV['RACK_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'shoulda-matchers'
require 'rack/test'
require 'capybara'
require 'capybara/rspec'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

def app
  Sinatra::Application
end

Capybara.app = app.new