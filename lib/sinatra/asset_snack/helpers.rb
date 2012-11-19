module Sinatra
  module AssetSnack
    module Helpers

      def nocache(url)
        "#{url}?cb=#{Time.now.to_i}"
      end

    end # Helpers
  end # AssetSnack
end # Sinatra