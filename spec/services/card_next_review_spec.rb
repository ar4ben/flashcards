require 'rails_helper'

describe CardNextReview do
  before(:each) do
    @user = create(:user)
    @deck = create(:deck, user: @user)
    @card = create(:card, user: @user, deck: @deck)
    @params = { card_id: @card.id }
  end

  def set_correct_review_date(next_review, quality)
    update_params = CardNextReview.new(@card.repetition, quality, @card.ef).calculate
    @card.update(update_params)
    @card.reload
    card_review = @card.review_date.strftime("%d-%H")
    expected_review = next_review.since.strftime("%d-%H")
    expect(card_review).to eq(expected_review)
  end

  def next_rev
    next_r = (@card.repetition - 1) * @card.ef
    next_r.round.days
  end

  it ".calculate should set correct review date for excellent answers" do
    set_correct_review_date(1.day, 5)
    set_correct_review_date(6.days, 5)
    set_correct_review_date(next_rev, 5)
    set_correct_review_date(next_rev, 5)
  end

  it ".calculate should set correct review date for good answers" do
    set_correct_review_date(1.day, 4)
    set_correct_review_date(6.days, 4)
    set_correct_review_date(next_rev, 3)
    set_correct_review_date(next_rev, 3)
  end

  it ".calculate should set correct review date for bad answers" do
    set_correct_review_date(1.day, 2)
    set_correct_review_date(1.day, 1)
  end
end
