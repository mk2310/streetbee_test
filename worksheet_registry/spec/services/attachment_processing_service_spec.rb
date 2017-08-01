require 'rails_helper'

RSpec.describe AttachmentProcessingService do
  let(:files) do
    [
      ActionDispatch::Http::UploadedFile.new(tempfile: File.open("spec/test_files/#{filename}", 'r'), filename: filename)
    ]
  end

  let(:filename) { 'test.png' }

  let(:uuid) { '5899113d-f5e8-4340-9a85-09991c74d641' }

  describe '#create_worksheet' do
    it 'should create worksheet' do
      described_class.new.create_worksheet
      expect(Worksheet.all.count).to eql 1
    end
  end

  describe '#perform' do
    before do
      allow(SecureRandom)
        .to receive(:uuid)
        .and_return(uuid)
      allow_any_instance_of(FileManageService)
        .to receive(:write_file).and_return([uuid, filename].join('_'))
      allow(AttachmentPublisher)
        .to receive(:publish)
    end

    it 'should save file and create attachment' do
      described_class.new.perform(files)
      expect(Attachment.all.count).to eql 1
      expect(Attachment.first.worksheet).not_to be nil
      expect(Attachment.first.filename).to eql [uuid, filename].join('_')
      expect(Attachment.first.state).to eql 'sent_for_processing'
    end
  end
end
