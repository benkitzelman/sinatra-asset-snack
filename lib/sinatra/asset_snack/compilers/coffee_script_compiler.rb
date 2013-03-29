module Sinatra
  module AssetSnack
    module Compilers
      class CoffeeScriptCompiler < AssetCompiler
        handle_extensions :coffee
        mime_type 'text/js'

        def compile(coffee_script, file_path = nil)
          CoffeeScript.compile(coffee_script, self.class.configuration)
        end
      end
    end # Compilers
  end # AssetSnack
end # Sinatra
