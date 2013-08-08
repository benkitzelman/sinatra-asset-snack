unless defined?(APP_FILE)
  $stderr.write "Error: Please set APP_FILE before setting up AssetSnack rake tasks.\n"
  $stderr.write "Example:\n"
  $stderr.write "    APP_FILE  = 'init.rb'\n"
  $stderr.write "    require 'sinatra/asset_snack/rake'\n"
  $stderr.write "\n"
  exit
end

namespace :assetsnack do
  desc "Build assets"
  task :build do
    require File.expand_path(APP_FILE, Dir.pwd)
    require 'sinatra/asset_snack/precompile'
    Sinatra::AssetSnack.precompile!(verbose:true)
  end
end
