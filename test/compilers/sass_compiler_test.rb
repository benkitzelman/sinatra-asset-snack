require './test/test_helper'

module Sinatra
  describe AssetSnack::Compilers::SassCompiler do
    subject { AssetSnack::Compilers::SassCompiler.new }
    let(:scss_file_path) { File.join File.dirname(__FILE__), '../', 'fixtures', 'test.scss' }
    let(:sass_file_path) { File.join File.dirname(__FILE__), '../', 'fixtures', 'test.sass' }
    let(:source)         { File.read scss_file_path }
    let(:compiled) {
<<-EOS
.content-navigation {
  border-color: #3bbfce;
  color: #2ca2af; }

.border {
  padding: 8px;
  margin: 8px;
  border-color: #3bbfce; }
EOS
    }

    it 'must compile a sass file' do
      subject.class.compile_file(sass_file_path).must_equal compiled
    end

    it 'must compile a scss file' do
      subject.class.compile_file(scss_file_path).must_equal compiled
    end

    it 'must compile scss' do
      css = subject.compile source
      css.must_equal compiled
    end

    it 'should handle files with extension scss' do
      subject.class.handled_extensions.must_include :scss
    end

    it 'should handle files with extension sass' do
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