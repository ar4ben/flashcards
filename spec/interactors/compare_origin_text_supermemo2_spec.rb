require 'rails_helper'

describe CompareOriginTextSupermemo2 do
  before(:all) do
    @user = create(:user)
    @deck = create(:deck, user: @user)
    @card = create(:card, user: @user, deck: @deck)
    @params = { card_id: @card.id }
  end

  def set_correct_review_date(next_review, success, time)
    @params[:original_text] = if success
                                @card.original_text
                              else
                                @card.translated_text
                              end
    @params[:time] = time
    @card.update_attribute(:updated_at, Date.yesterday)
    CompareOriginTextSupermemo2.call(params: @params)
    @card.reload
    card_review = @card.review_date.strftime("%d-%H")
    expected_review = next_review.since.strftime("%d-%H")
    expect(card_review).to eq(expected_review)
  end

  it ".call should compare user text with original" do
    @params[:original_text] = @card.original_text
    interactor = CompareOriginTextSupermemo2.call(params: @params)
    expect(interactor.notice).to eq "Правильно!"
    @params[:original_text] = "#{@card.original_text}!"
    interactor = CompareOriginTextSupermemo2.call(params: @params)
    expect(interactor.notice).to include "Это правильный перевод"
    @params[:original_text] = 'go'
    interactor = CompareOriginTextSupermemo2.call(params: @params)
    expect(interactor.notice).to eq "Неправильно!"
  end

  def next_rev
    next_r = (@card.repetition - 1) * @card.ef
    next_r.round.days
  end

  it ".call should set correct review date" do
    set_correct_review_date(1.day, true, 10)
    set_correct_review_date(6.days, true, 10)
    set_correct_review_date(next_rev, true, 10)
    set_correct_review_date(1.day, false, 10)
  end
end
