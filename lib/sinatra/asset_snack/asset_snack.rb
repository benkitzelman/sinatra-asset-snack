module Sinatra
  module AssetSnack
    class << self
      attr_reader :compilers

      def registered(app)
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
        @compilers[ext.to_sym] unless ext.nil?
      end
    end # self

    module ClassMethods
      def asset_map(route, paths)
        self.get route do
          content = compile paths
          [200, {'Content-Type' => content[:mime_type]}, content[:body]]
        end
      end
    end # ClassMethods

    module InstanceMethods
      def compile(paths)
        expand(paths).reduce({body: ''}) do |content, path|
          next unless File.exists?(path)

          if compiler = AssetSnack.compiler_for(path)
            compiled = compiler.compile_file(path)
            content_type = compiler.compiled_mime_type
          else
            compiled = File.read(path)
          end

          {
            mime_type: content_type || content[:mime_type] || 'text/plain',
            body: content[:body] + "\n\n/** #{File.basename path} **/\n\n" + compiled
          }
        end
      end

      def expand(paths)
        paths.reduce([]) { |file_list, path| file_list + Dir.glob(path) }.uniq
      end
    end #InstanceMethods
  end # AssetSnack
end #Sinatra
