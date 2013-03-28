require 'sass'
require 'coffee-script'

here = File.dirname(__FILE__)
Dir[File.join(here, 'asset_snack', '*.rb')].each { |f| require f }
Dir[File.join(here, 'asset_snack', 'compilers', '*.rb')].each { |f| require f }