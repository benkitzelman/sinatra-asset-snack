require './test/test_helper'

module Sinatra
  describe AssetSnack::Compilers::CoffeeScriptCompiler do
    subject { AssetSnack::Compilers::CoffeeScriptCompiler.new }
    let(:file_path) { File.join File.dirname(__FILE__), '../', 'fixtures', 'test.coffee' }
    let(:source)    { '-> x = "test"' }
    let(:compiled)  {
  <<-EOS
(function() {
  (function() {
    var x;
    return x = "test";
  });

}).call(this);
  EOS
    }

    before do
      Sinatra::AssetSnack.configuration.compilers[:coffee_script] = {}
    end

    it 'must compile a coffeesript file' do
      subject.class.compile_file(file_path).must_equal compiled
    end

    it 'must compile coffeescript' do
      js = subject.compile source
      js.must_equal compiled
    end

    it 'should handle files with extension coffee' do
      subject.class.handled_extensions.must_include :coffee
    end

    it 'should compile to text/js' do
      subject.class.compiled_mime_type.must_equal 'application/javascript'
    end

    it 'should register itself with the AssetCompiler' do
      AssetSnack.compiler_for('test.coffee').must_equal AssetSnack::Compilers::CoffeeScriptCompiler
    end
  end
end
