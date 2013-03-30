require 'mime/types'
require 'sass'
require 'coffee-script'

here = File.dirname(__FILE__)

require File.join here, 'asset_snack', 'compilers', 'asset_compiler'

Dir[File.join(here, 'asset_snack', '*.rb')].each { |f| require f }
Dir[File.join(here, 'asset_snack', 'compilers', '*.rb')].each { |f| require f }