require 'rails_helper'

RSpec.describe V1::ImagesController, type: :controller do
  after do
    FileUtils.rm_rf("tmp/#{Date.today}")
  end
  describe '#show' do
    let(:resp) do
      {
        file: Base64.encode64(File.read("tmp/#{Date.today}/1_test.png"))
      }.with_indifferent_access
    end

    before :each do
      FactoryGirl.create('attachment')
      FileUtils.mkdir("tmp/#{Date.today}")
      FileUtils.cp('spec/test_files/test.png', "tmp/#{Date.today}/1_test.png")
    end

    describe 'when params correct' do
      it 'should return json with file' do
        get :show, params: { id: Attachment.first.id }
        expect(JSON.parse(response.body)).to eql resp
      end
    end

    describe 'when params incorrect' do
      it 'should return json with file' do
        get :show, params: { id: SecureRandom.uuid }
        expect(JSON.parse(response.body)).to eql(
          { error: 'something went wrong' }.with_indifferent_access
        )
      end
    end
  end

  describe '#create' do
    before :each do
      FactoryGirl.create('attachment')
      FileUtils.mkdir("tmp/#{Date.today}")
      FileUtils.cp('spec/test_files/test.png', "tmp/#{Date.today}/1_test.png")
    end

    describe 'when params correct' do
      it 'should upload processed file' do
        post :create, params: { id: Attachment.first.id, file: Base64.encode64(File.read("tmp/#{Date.today}/1_test.png")) }
        expect(JSON.parse(response.body)).to eql(
          {
            state: 0
          }.with_indifferent_access
        )
        expect(File.exist? "tmp/#{Date.today}/#{Attachment.first.processed_filename}").to be true
      end
    end

    describe 'when params incorrect' do
      it 'should upload processed file' do
        post :create, params: { id: SecureRandom.uuid, file: Base64.encode64(File.read("tmp/#{Date.today}/1_test.png")) }
        expect(JSON.parse(response.body)).to eql(
          {
            state: 1
          }.with_indifferent_access
        )
      end
    end
  end
end
