require 'rails_helper'

describe HomeController, type: :controller do
  before(:each) do
    @user = create(:user)
    @deck = create(:deck, user: @user)
    @card = create(:card, user: @user, deck: @deck)
  end

  it "should be success with xhr" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    xhr :post, :check, random_card: {
      original_text: @card.original_text,
      card_id: @card.id,
      time: "10"
    }
    expect(response.status).to eq(200)
  end
end
