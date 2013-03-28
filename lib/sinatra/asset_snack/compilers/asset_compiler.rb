module Sinatra
  module AssetSnack
    module Compilers
      class AssetCompiler

        class << self
          attr_reader :compiled_mime_type, :handled_extensions

          def compile_file(file_path)
            ext = File.extname(file_path).downcase[1..-1]
            return unless ext && handled_extensions.include?(ext.to_sym)

            file_content = File.read file_path
            new.compile(file_content)
          end

          def handle_extensions(*extensions)
            @handled_extensions = extensions
            AssetSnack.register_compiler self, extensions
          end

          def mime_type(type)
            @compiled_mime_type = type
          end
        end

        def compile
          throw "Not Implemented"
        end
      end
    end #Compilers
  end #Asset
end #Sinatra