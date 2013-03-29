require './test/test_helper'
module Sinatra::AssetSnack
  describe Configuration do

    it 'should allow setting of compiler configuration' do
      config = Configuration.new { |c| c.compilers[:coffee_script] = {bare: true} }
      config.compilers[:coffee_script].must_equal(bare: true)
    end
  end
end