ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'minitest/spec'
require "minitest/reporters"
require "mocha/setup"
require 'rack/test'
require 'sinatra/base'
require './lib/sinatra/asset_snack'
MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new

class App < Sinatra::Base
  register Sinatra::AssetSnack

  asset_map '/javascript/application.js', ['test/fixtures/**/*.coffee']
  asset_map '/javascript/application_js_only.js', ['test/fixtures/**/*.js']
  asset_map '/stylesheets/application.css', ['test/fixtures/**/*.scss']
end
