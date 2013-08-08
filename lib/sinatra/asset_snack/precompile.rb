require 'fileutils'

module Sinatra
  module AssetSnack
    def self.precompile!(opts={})
      snack = self
      Module.new do
        extend snack::InstanceMethods
        snack.assets.each do |assets|
          path = File.join(snack.app.public_dir, assets[:route])
          FileUtils.mkdir_p File.dirname(path)
          puts "compiling #{path}" if opts[:verbose]
          File.open(path, 'w') do |file|
            file.write compile(assets[:paths])[:body]
          end
        end
      end
    end
  end
end

