require 'rails_helper'

RSpec.describe WorksheetsController, type: :controller do
  before do
    FactoryGirl.create(:user)
  end

  let(:user_login) do
    { login: User.first.login, password: User.first.password }
  end

  describe '#index' do
    let(:list) do
      [{ worksheet_id: 1, image_path: '/1' }]
    end

    before do
      allow(WorksheetsPresenter).to receive(:show_list).and_return(
        list
      )
    end

    it 'should return list' do
      get :index, params: { login: user_login }
      expect(response.body).to eql(
        {
          list: list,
          worksheet_url: worksheets_url
        }.to_json
      )
    end
  end

  describe '#show' do
    let(:record) do
      { worksheet_id: 1, image_path: '/1' }
    end

    before do
      allow(WorksheetsPresenter).to receive(:show_record).and_return(
        record
      )
    end

    it 'should return record' do
      get :show, params: { id: 1, login: user_login }
      expect(response.body).to eql(
        {
          record: record,
          worksheet_url: worksheet_url(1)
        }.to_json
      )
    end
  end
end
