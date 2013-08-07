require 'fileutils'

module Sinatra
  module AssetSnack
    def self.precompile!
      snack = self
      Module.new do
        extend snack::InstanceMethods
        snack.assets.each do |assets|
          path = File.join(snack.app.public_dir, assets[:route])
          FileUtils.mkdir_p File.dirname(path)
          File.open(path, 'w') do |file|
            file.write compile(assets[:paths])[:body]
          end
        end
      end
    end
  end
end

