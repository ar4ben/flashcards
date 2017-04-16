require 'rails_helper'

RSpec.describe Dashboard::CardsController, type: :controller do

  before(:each) do
    users = create_list(:user, 2)
    @owner, @other = users
    @deck = create(:deck, user: @owner)
    @card = create(:card, user: @owner, deck: @deck)
  end

  context 'Cards availability' do
    it 'should be shown for the owner' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@owner)
      get "show", id: @card
      expect(response.status).to eq(200)
    end

    it 'should be hidden for others' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@other)
      get "show", id: @card
      expect(response.status).to eq(302)
    end
  end
end
