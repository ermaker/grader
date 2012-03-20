require 'grader'
describe Grader do
  describe '#exact_zipfilename?' do
    it 'returns true with the valid path' do
      subject.path = 'fixtures/20120227.zip'
      subject.should be_exact_zipfilename
    end

    it 'returns true with the double-uploaded valid path' do
      subject.path = 'fixtures/20120227[1].zip'
      subject.should be_exact_zipfilename
    end

    it 'returns false with the invalid path' do
      subject.path = 'fixtures/yourid.zip'
      subject.should_not be_exact_zipfilename
    end
  end

  describe '#yourid' do
    it 'returns the correct id with the valid path' do
      subject.path = 'fixtures/20120227.zip'
      subject.yourid.should == '20120227'
    end

    it 'returns the correct id with the double-uploaded valid path' do
      subject.path = 'fixtures/20120227.zip'
      subject.yourid.should == '20120227'
    end

    it 'returns the good id with the invalid path' do
      subject.path = 'fixtures/20120227_1.zip'
      subject.yourid.should == '20120227'
    end

    it 'returns nil if the expected id is not found' do
      subject.path = 'fixtures/short_number_2012.zip'
      subject.yourid.should be_nil
    end
  end

  describe '#pyfilename' do
    before do
      subject.path = 'fixtures/20120227.zip'
      subject.stub!(:files).and_return { ['20120227.py'] }
    end

    it 'returns the correct filename' do
      subject.pyfilename.should == '20120227.py'
    end
  end

  describe '#wldfilename' do
    before do
      subject.path = 'fixtures/20120227.zip'
      subject.stub!(:files).and_return { ['20120227.wld'] }
    end

    it 'returns the correct filename' do
      subject.wldfilename.should == '20120227.wld'
    end
  end

  describe '#docfilename' do
    before do
      subject.path = 'fixtures/20120227.zip'
    end

    it 'returns the correct filename with docx extension' do
      subject.stub!(:files).and_return { ['20120227.docx'] }
      subject.docfilename.should == '20120227.docx'
    end

    it 'returns the correct filename with doc extension' do
      subject.stub!(:files).and_return { ['20120227.doc'] }
      subject.docfilename.should == '20120227.doc'
    end
  end

  describe '#run' do
    it 'returns true with a working file' do
      subject.path = 'fixtures/20120227.zip'
      subject.stub!(:file).and_return { File.read('fixtures/correct.py') }
      subject.run('fixtures/maze1.wld').should be_true
    end

    it 'returns false with an empty file' do
      subject.path = 'fixtures/20120227.zip'
      subject.stub!(:file).and_return { File.read('fixtures/empty.py') }
      subject.run('fixtures/maze1.wld').should_not be_true
    end
  end
end
