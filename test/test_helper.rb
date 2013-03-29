ENV['RACK_ENV'] = 'test'
require 'minitest/spec'
require 'minitest/autorun'
require "minitest/reporters"
require "mocha/setup"
require 'rack/test'
require 'sinatra/base'
require './lib/sinatra/asset_snack'
MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new

class App < Sinatra::Base
  Sinatra::AssetSnack.configure do |config|
    config.compilers[:coffee_script] = {bare: true}
  end
  register Sinatra::AssetSnack
  asset_map '/javascript/application.js', ['test/fixtures/**/*.coffee']
  asset_map '/stylesheets/application.css', ['test/fixtures/**/*.scss']
end
