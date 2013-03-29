require './test/test_helper'

module Sinatra
  describe AssetSnack::Compilers::SassCompiler do
    let(:file_path) { File.join File.dirname(__FILE__), '../', 'fixtures', 'test.scss' }
    subject { AssetSnack::Compilers::SassCompiler.new }
    let(:source) {
<<-EOS
.test{
  .one {
    color: red;
  }
}
EOS
    }

    let(:compiled) {
<<-EOS
.test .one {
  color: red; }
EOS
    }

    it 'must compile a sass file' do
      subject.class.compile_file(file_path).must_equal compiled
    end

    it 'must compile sass' do
      css = subject.compile source
      css.must_equal compiled
    end

    it 'should handle files with extension scss' do
      subject.class.handled_extensions.must_include :scss
    end

    it 'should handle files with extension scss' do
      subject.class.handled_extensions.must_include :sass
    end

    it 'should compile to text/css' do
      subject.class.compiled_mime_type.must_equal 'text/css'
    end

    it 'should register itself with the AssetCompiler' do
      AssetSnack.compiler_for('test.scss').must_equal AssetSnack::Compilers::SassCompiler
    end
  end
end