require './test/test_helper'
include Rack::Test::Methods

module Sinatra
  describe AssetSnack do
    let(:app) { App.new }

    it "must include the helpers" do
      app.helpers.respond_to?(:nocache).must_equal true
    end

    it 'should stitch gouped assets into a common file' do
      get '/javascript/application.js'
      last_response.body.must_include '/** test.coffee **/'
      last_response.body.must_include '/** test_two.coffee **/'
    end

    it 'should return the compilers mime type as a header' do
      get '/javascript/application.js'
      last_response.headers['Content-Type'].must_equal 'text/js'
    end

    it 'should allow compiler configuration' do
      Sinatra::AssetSnack.configuration.compilers[:coffee_script] = {bare: true}

      get '/javascript/application.js'
      last_response.body.wont_include ').call(this);'
    end

    it 'should remember each mapped asset' do
      js_assets  = {route: '/javascript/application.js',   paths: ['test/fixtures/**/*.coffee']}
      css_assets = {route: '/stylesheets/application.css', paths: ['test/fixtures/**/*.scss']}

      Sinatra::AssetSnack.assets.must_include js_assets
      Sinatra::AssetSnack.assets.must_include css_assets
    end
  end
end