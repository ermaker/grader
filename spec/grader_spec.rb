require 'grader'
describe Grader do
  describe '#valid_zip_filename?' do
    it 'returns true with the valid path' do
      subject.path = 'fixtures/20120227.zip'
      subject.should be_valid_zip_filename
    end

    it 'returns true with the double-uploaded valid path' do
      subject.path = 'fixtures/20120227[1].zip'
      subject.should be_valid_zip_filename
    end

    it 'returns false with the invalid path' do
      subject.path = 'fixtures/yourid.zip'
      subject.should_not be_valid_zip_filename
    end
  end
end
