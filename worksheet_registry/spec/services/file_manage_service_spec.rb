require 'rails_helper'

RSpec.describe FileManageService do
  let(:uuid) { '5899113d-f5e8-4340-9a85-09991c74d641' }
  let(:filename) { 'test.png' }
  let(:file) { File.open("spec/test_files/#{filename}", 'r') }

  after do
    FileUtils.rm_rf(
      File.join(
        Rails.root,
        'tmp',
        Date.today.to_s
      )
    )
  end

  describe '#write_file' do
    before do
      allow(SecureRandom)
        .to receive(:uuid)
        .and_return(uuid)
    end

    it 'should create file' do
      described_class.new.write_file(file.read, 'test.png')
      expect(
        File.exist? File.join(
          Rails.root,
          'tmp',
          Date.today.to_s,
          [uuid, filename].join('_')
        )
      ).to be true
    end
  end

  describe '#get_file' do
    before do
      allow(SecureRandom)
        .to receive(:uuid)
        .and_return(uuid)
      described_class.new.write_file(file.read, 'test.png')
    end

    it 'should return file' do
      expect(
        described_class
          .new
          .get_file([uuid, filename].join('_'), Date.today.to_s).path
      ).to eql(
        File.join(
          Rails.root,
          'tmp',
          Date.today.to_s,
          [uuid, filename].join('_')
        )
      )
    end
  end

  describe '#file_path' do
    describe 'when directory present' do
      let(:filename) { 'filename.type' }
      let(:directory_name) { 'directory' }

      it 'should return path to file with custom directory name' do
        expect(described_class.new.file_path(filename, directory_name))
          .to eql(File.join(Rails.root, 'tmp', directory_name, filename))
      end
    end

    describe 'when directory not present' do
      let(:filename) { 'filename.type' }

      it 'should return path to file
        with standard (Date.today) directory name' do
        expect(described_class.new.file_path(filename))
          .to eql(File.join(Rails.root, 'tmp', Date.today.to_s, filename))
      end
    end
  end

  describe '#file_name' do
    let(:filename) { 'filename.type' }

    before do
      allow(SecureRandom)
        .to receive(:uuid)
        .and_return(uuid)
    end

    it 'should return file name with uuid' do
      expect(
        described_class
          .new
          .file_name(filename)
      ).to eql([uuid, filename].join('_'))
    end
  end

  describe '#file_dir_path' do
    describe 'when directory present' do
      let(:directory_name) { 'directory' }

      it 'should return path to file with custom directory name' do
        expect(
          described_class
            .new
            .file_dir_path(directory_name)
        ).to eql(File.join(Rails.root, 'tmp', directory_name))
      end
    end

    describe 'when directory not present' do
      let(:filename) { 'filename.type' }

      it 'should return path to file with standard
        (Date.today) directory name' do
        expect(
          described_class
            .new
            .file_dir_path
        ).to eql(File.join(Rails.root, 'tmp', Date.today.to_s))
      end
    end
  end

  describe '#directory' do
  end
end
