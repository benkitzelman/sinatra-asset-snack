module Sinatra
  module AssetSnack
    class << self
      attr_reader :compilers, :configuration

      def registered(app, &block)
        @configuration = Configuration.new

        app.extend ClassMethods
        app.send(:include, InstanceMethods)
        app.send(:helpers, Helpers)
      end

      def register_compiler(compiler, handled_extensions)
        @compilers ||= {}
        handled_extensions.each do |ext|
          @compilers[ext.downcase.to_sym] = compiler
        end
      end

      def compiler_for(file_path)
        ext = (File.extname(file_path) || '.').downcase[1..-1]
        @compilers[ext.to_sym]
      end

      def assets
        @assets ||= []
      end
    end # self

    module ClassMethods
      def asset_map(route, paths)
        AssetSnack.assets << {route: route, paths: paths}

        self.get route do
          content = compile paths
          [200, {'Content-Type' => content[:mime_type]}, content[:body]]
        end
      end
    end # ClassMethods

    module InstanceMethods
      def compile(paths)
        expand(paths).reduce({body: '', mime_type: 'text/plain'}) do |content, path|
          next unless File.exists?(path)

          if compiler = AssetSnack.compiler_for(path)
            compiled = compiler.compile_file(path)
            content_type = compiler.compiled_mime_type
          else
            compiled = File.read path
            content_type = MIME::Types.type_for(path).first.to_s
          end

          {
            mime_type: content_type || content[:mime_type],
            body: content[:body] + "\n\n/** #{File.basename path} **/\n\n" + compiled
          }
        end
      end

      def expand(paths)
        paths.reduce([]) do |file_list, path|
          file_list += File.file?(path) ? [path] : Dir.glob(path)
        end.uniq
      end
    end # InstanceMethods
  end # AssetSnack
end # Sinatra
