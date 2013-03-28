module Sinatra
  module AssetSnack
    module Compilers
      class CoffeeScriptCompiler < AssetCompiler
        handle_extensions :coffee
        mime_type 'text/js'

        def compile(coffee_script)
          CoffeeScript.compile(coffee_script, {bare: true})
        end
      end
    end # Compilers
  end # AssetSnack
end # Sinatra
