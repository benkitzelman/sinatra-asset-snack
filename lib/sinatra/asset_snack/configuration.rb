module Sinatra
  module AssetSnack
    class Configuration
      attr_reader :compilers

      def initialize(&block)
        instance_exec(self, &block) unless block.nil?
      end

      def compilers
        @compilers ||= Hash.new.tap do |hash|
          Compilers.constants.each do |compiler|
            next if compiler == :AssetCompiler
            hash[ Compilers.const_get(compiler).key ] = {}
          end
        end
      end

    end # Configuration
  end # AssetSnack
end # Siantra