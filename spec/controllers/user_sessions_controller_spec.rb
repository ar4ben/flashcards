require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
  before(:each) do
    @user = create(:user)
  end

  context 'Login' do
    it 'should work for existed user' do
      post :create, user_sessions: { email: @user.email, password: "password" }
      expect(flash[:notice]).to eq("Успешный вход")
    end
  end
end
