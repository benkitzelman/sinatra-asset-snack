require './lib/sinatra/asset_snack/version'
Gem::Specification.new do |s|
  s.name        = 'sinatra-asset-snack'
  s.version     = Sinatra::AssetSnack.version
  s.summary     = 'Real quick asset compilation of Coffeescript to Javascript and SASS to CSS for Sinatra'
  s.description = 'Simple and effective asset compilation, supporting Coffeescript and SASS. A lean alternative to larger, slower asset management gems.'
  s.authors     = ['Ben Kitzelman']
  s.email       = ['benkitzelman@hotmail.com']
  s.homepage    = 'http://github.com/benkitzelman/sinatra-asset-snack'
  s.files       = `git ls-files`.strip.split("\n")
  s.executables = Dir['bin/*'].map { |f| File.basename(f) }

  s.add_dependency 'sinatra'
  s.add_dependency 'coffee-script'
  s.add_dependency 'sass'
  s.add_dependency 'yajl'
  s.add_dependency 'mime-types'

  s.add_development_dependency "minitest"
  s.add_development_dependency "minitest-reporters"
  s.add_development_dependency "mocha"
  s.add_development_dependency "rake"
  s.add_development_dependency "rack-test"
end
