require 'rubygems'

# All our specs should require 'spec_helper' (this file)

# If RACK_ENV isn't set, set it to 'test'.  Sinatra defaults to development,
# so we have to override that unless we want to set RACK_ENV=test from the
# command line when we run rake spec.  That's tedious, so do it here.
ENV['RACK_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rack/test'
require 'capybara'
require 'capybara/rspec'
require_relative '../app/helpers/level_names'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include LevelNames
end

def app
  Sinatra::Application
end

Capybara.app = app.new
