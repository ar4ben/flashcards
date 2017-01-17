require 'rails_helper'

describe CompareOriginText do
  before(:all) do
    @user = create(:user)
    @deck = create(:deck, user: @user)
    @card = create(:card, user: @user, deck: @deck)
    @params = { card_id: @card.id }
  end

  def set_correct_review_date(next_review, success, levenshtein = false)
    @params[:original_text] = if levenshtein
                                "#{@card.original_text}!"
                              elsif success
                                @card.original_text
                              else
                                @card.translated_text
                              end
    CompareOriginText.call(params: @params)
    @card.reload
    card_review = @card.review_date.strftime("%d-%H")
    expected_review = next_review.since.strftime("%d-%H")
    expect(card_review).to eq(expected_review)
    expect(@card.fail).to eq(0) if levenshtein
  end

  it ".call should compare user text with original" do
    @params[:original_text] = @card.original_text
    interactor = CompareOriginText.call(params: @params)
    expect(interactor.notice).to eq "Правильно!"
    @params[:original_text] = 'go'
    interactor = CompareOriginText.call(params: @params)
    expect(interactor.notice).to eq "Неправильно!"
  end

  it ".call should set correct review date" do
    set_correct_review_date(12.hours, true)
    set_correct_review_date(3.days, true)
    set_correct_review_date(1.week, true)
    set_correct_review_date(2.weeks, true)
    set_correct_review_date(1.month, true)
    set_correct_review_date(1.month, false)
    set_correct_review_date(1.month, false)
    set_correct_review_date(12.hours, false)
    set_correct_review_date(12.hours, true, true)
  end
end
