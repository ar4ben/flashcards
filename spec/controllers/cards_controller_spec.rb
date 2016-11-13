require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  before(:each) do
    users = create_list(:user, 2)
    @owner, @other = users
    @card = create(:card, user: @owner)
  end

  context 'Cards availability' do
    it 'should be shown for the owner' do
      login_user_post(@owner, "password")
      get "show", id: @card
      expect(response.status).to eq(200)
    end

    it 'should be hidden for others' do
      login_user_post(@other, "password")
      get "show", id: @card
      expect(response.status).to eq(302)
    end
  end
end
