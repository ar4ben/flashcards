require 'rails_helper'

describe CompareOriginText do
  before(:all) do
    @user = create(:user)
    @deck = create(:deck, user: @user)
    @card = create(:card, user: @user, deck: @deck)
    @params = { card_id: @card.id }
  end

  it ".call should compare user text with original" do
    @params[:original_text] = @card.original_text
    interactor = CompareOriginText.call(params: @params)
    expect(interactor.notice).to eq "Правильно!"
    @params[:original_text] = "#{@card.original_text}!"
    interactor = CompareOriginText.call(params: @params)
    expect(interactor.notice).to include "Это правильный перевод"
    @params[:original_text] = 'go'
    interactor = CompareOriginText.call(params: @params)
    expect(interactor.notice).to eq "Неправильно!"
  end

end
