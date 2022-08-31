require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe "Post /users" do
    it 'Create a new user' do
      expect do
        post users_path, params: {email: 'test@example.com',username: 'test',password: 'password'}
      end.to change { User.count }.by(1)
    end
  end
  describe "Perform Action on controller" do
    before(:each) do
      post users_path, params: {email: 'test@example.com',username: 'test',password: 'password'}
      post users_path, params: {email: 'test1@example.com',username: 'test1',password: 'password'}
      post auth_login_path, params: {email: 'test@example.com',password:'password'}
    end
    it "GET /users" do
      body = JSON.parse(response.body)
      get users_path, headers: {authorization: body["token"]}
      expect(response).to be_successful
      expect(assigns(:users)).to eq(User.all)
    end
  end
end
