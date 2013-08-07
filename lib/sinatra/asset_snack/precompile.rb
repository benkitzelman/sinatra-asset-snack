require 'fileutils'

module Sinatra
  module AssetSnack
    extend InstanceMethods

    def self.precompile!
      self.assets.each do |assets|
        path = File.join(self.app.public_dir, assets[:route])
        FileUtils.mkdir_p File.dirname(path)
        File.open(path, 'w') do |file|
          file.write compile(assets[:paths])[:body]
        end
      end
    end
  end
end

