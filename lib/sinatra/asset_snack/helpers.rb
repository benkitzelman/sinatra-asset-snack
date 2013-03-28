module Sinatra
  module AssetSnack
    module Helpers

      def nocache(url)
        uri    = URI.parse(url)
        params = Rack::Utils.parse_query(uri.query).merge(cb: Time.now.to_i)
        uri.query = Rack::Utils.build_query params
        uri.to_s
      end

    end # Helpers
  end # AssetSnack
end # Sinatra