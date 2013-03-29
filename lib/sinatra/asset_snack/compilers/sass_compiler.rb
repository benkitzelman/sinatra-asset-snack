module Sinatra
  module AssetSnack
    module Compilers
      class SassCompiler < AssetCompiler
        handle_extensions :scss, :sass
        mime_type 'text/css'

        def compile(sass_script)
          Sass.compile(sass_script, self.class.configuration)
        end
      end
    end # Compilers
  end # AssetSnack
end # Sinatra
