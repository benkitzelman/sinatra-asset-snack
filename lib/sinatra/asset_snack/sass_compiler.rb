module Sinatra
  module AssetSnack
    class SassCompiler < AssetCompiler
      handle_extensions :scss
      mime_type 'text/css'

      def compile(sass_script)
        Sass.compile(sass_script)
      end
    end
  end
end
