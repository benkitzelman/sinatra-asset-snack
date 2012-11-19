module Sinatra
  module AssetSnack
    class CoffeeCompiler < AssetCompiler
      handle_extensions :coffee
      mime_type 'text/js'

      def compile(coffee_script)
        CoffeeScript.compile(coffee_script, {bare: true})
      end
    end
  end
end
