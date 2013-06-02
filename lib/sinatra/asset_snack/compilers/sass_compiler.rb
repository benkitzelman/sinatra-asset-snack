module Sinatra
  module AssetSnack
    module Compilers
      class SassCompiler < AssetCompiler
        handle_extensions :scss, :sass
        mime_type 'text/css'

        def ext_for(file_path)
          AssetCompiler.ext_for file_path
        end

        def compile(sass_script, file_path = nil)
          config = self.class.configuration
          syntax = (file_path && ext_for(file_path) == 'sass') ? :sass : :scss
          Sass.compile sass_script, config.merge(syntax: syntax)
        end
      end
    end # Compilers
  end # AssetSnack
end # Sinatra
