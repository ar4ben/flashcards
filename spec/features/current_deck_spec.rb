require 'rails_helper'

describe 'On home page' do
  before(:each) do
    @user = create(:user)
    @current_deck, @deck = create_list(:deck, 2, user: @user)
    @user.update_attribute(:deck_id, @current_deck.id)
    @card_from_curr_deck, @card = create_list(:card, 2, user: @user, deck: @current_deck)
    @card.update_attribute(:deck_id, @deck)
    [@card_from_curr_deck, @card].each { |card| card.update_attribute(:review_date, DateTime.now) }
    login_user(@user, "password")
  end

  after(:each) do
  end

  context "card" do
    it "should be shown if it's from current deck" do
      expect(page).to have_content @card_from_curr_deck.translated_text
    end

    it "shouldn't be shown if it's not from current deck" do
      expect(page).not_to have_content @card.translated_text
    end
  end
end
