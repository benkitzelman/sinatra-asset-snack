require './test/test_helper'

module Sinatra::AssetSnack
  describe "Sinatra::AssetSnack.precompile!" do
    let(:app) { App.new }
    let(:public) { App.public_dir }
    let(:paths) do
      Sinatra::AssetSnack.assets.map do |i| 
        File.join(public, File.dirname(i[:route]))
      end
    end

    before do
      FileUtils.rm_r(public) if Dir.exists?(public)
    end

    it "must write compiled files to the public directory" do
      Sinatra::AssetSnack.precompile!
      paths.wont_be_empty
      paths.each {|dir| Dir.glob("#{dir}/*").wont_be_empty }
    end

    after do
      FileUtils.rm_r(public) if Dir.exists?(public)
    end
  end
end
