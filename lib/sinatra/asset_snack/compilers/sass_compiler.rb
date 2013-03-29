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
          if file_path && ext_for(file_path) == 'sass'
            config.merge!(syntax: :sass)
          end

          Sass.compile(sass_script, config)
        end
      end
    end # Compilers
  end # AssetSnack
end # Sinatra
