require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#create' do
    describe 'then required params present' do
      it 'should save attachments' do
        post :create, params: { user: { login: 'guest', password: 'guest' } }
        expect(response.body).to eql(
          {
            redirect_url: sign_in_users_url,
            message: 'User created'
          }.to_json
        )
      end
    end

    describe 'then one parameter not present' do
      it 'should save attachments' do
        post :create, params: { user: { login: 'guest' } }
        expect(response.body).to eql(
          {
            redirect_url: users_url,
            message: 'password: can\'t be blank'
          }.to_json
        )
      end
    end
  end

  describe '#sign_in' do
    before do
      FactoryGirl.create(:user)
    end

    describe 'then login and password present' do
      it 'should log in' do
        post :sign_in, params: { login: { login: 'guest', password: 'guest' } }
        expect(response.body).to eql(
          {
            redirect_url: worksheets_url,
            message: 'Successed'
          }.to_json
        )
      end
    end

    describe 'then login invalid' do
      it 'should not log in' do
        post :sign_in, params: { login: { login: 'guest1', password: 'guest' } }
        expect(response.body).to eql(
          {
            redirect_url: sign_in_users_url,
            message: 'User not registered'
          }.to_json
        )
      end
    end

  describe 'then password invalid' do
      it 'should not log in' do
        post :sign_in, params: { login: { login: 'guest', password: 'guest1' } }
        expect(response.body).to eql(
          {
            redirect_url: sign_in_users_url,
            message: 'User not registered'
          }.to_json
        )
      end
    end
  end
end
