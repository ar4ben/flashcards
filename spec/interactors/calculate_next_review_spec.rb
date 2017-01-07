require 'rails_helper'

describe CalculateNextReview do
  before(:all) do
    @user = create(:user)
    @deck = create(:deck, user: @user)
    @card = create(:card, user: @user, deck: @deck)
    @params = {
      card: @card.id,
      success_attempt: true
    }
  end

  context ".call should set review date in" do
    it "12 hours after now if it's first success attempt" do
      CalculateNextReview.call(@params)
      @card.reload
      card_review = @card.review_date.strftime("%d-%H")
      expected_review = (Time.now.utc + 12.hours).strftime("%d-%H")
      expect(card_review).to eq(expected_review)
    end

    it "3 days after now if it's second success attempt" do
      CalculateNextReview.call(@params)
      @card.reload
      card_review = @card.review_date.strftime("%d-%H")
      expected_review = (Time.now.utc + 3.days).strftime("%d-%H")
      expect(card_review).to eq(expected_review)
    end
  end
end
