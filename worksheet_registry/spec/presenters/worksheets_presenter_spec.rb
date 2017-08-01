require 'rails_helper'

RSpec.describe WorksheetsPresenter do
  describe '#show_list' do
    before do
      15.times do
        FactoryGirl.create(:worksheet, :with_attachment, processed: true)
      end
    end

    let(:result_list) do
      Worksheet.all.order(created_at: :desc).limit(1).map do |record|
        described_class.response(record)
      end
    end

    it 'should return record list' do
      expect(described_class.show_list(1)).to eql(result_list)
    end
  end

  describe '#show_record' do
    before do
      FactoryGirl.create(:worksheet, :with_attachment, processed: true)
    end

    let(:result) do
      described_class.response(Worksheet.first)
    end

    it 'should return record' do
      expect(described_class.show_record(Worksheet.first.id)).to eql(result)
    end
  end

  describe '#response' do
    before do
      FactoryGirl.create(:worksheet, :with_attachment, processed: true)
    end

    let(:hsh) do
      described_class.response(Worksheet.first)
    end

    it 'should return record hash' do
      expect(described_class.response(Worksheet.first)).to eql(hsh)
    end
  end
end
