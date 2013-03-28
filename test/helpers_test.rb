require './test/test_helper'
module Sinatra
  describe AssetSnack::Helpers do
    subject { Class.new { self.class.send(:include, AssetSnack::Helpers) }}

    it 'should apply a cache buster to a url' do
      subject.nocache('/mytest.js?somevar=123').must_match /\A\/mytest.js\?somevar=123&cb=\d+\z/
    end
  end
end