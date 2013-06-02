module Sinatra
  module AssetSnack
    module Compilers
      class AssetCompiler

        class << self
          attr_reader :compiled_mime_type, :handled_extensions

          def inherited(klass)
            klass.send(:define_singleton_method, :key) do
              short_name = name.split('::').last
              short_name.gsub(/compiler\z/i, '').underscore.to_sym
            end

            klass.send(:define_singleton_method, :configuration) do
              AssetSnack.configuration.compilers[klass.key]
            end
          end

          def ext_for(file_path)
            return if file_path.nil?
            File.extname(file_path).downcase[1..-1]
          end

          def compile_file(file_path)
            ext = ext_for file_path
            file_content = File.read file_path

            return file_content unless ext && (handled_extensions || []).include?(ext.to_sym)
            new.compile(file_content, file_path)
          end

          def handle_extensions(*extensions)
            @handled_extensions = extensions
            AssetSnack.register_compiler self, extensions
          end

          def mime_type(type)
            @compiled_mime_type = type
          end
        end

        def compile(script, file_path = nil)
          throw "Not Implemented"
        end
      end
    end #Compilers
  end #Asset
end #Sinatra
