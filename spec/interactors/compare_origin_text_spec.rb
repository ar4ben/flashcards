require 'rails_helper'

describe CompareOriginText do
  before(:all) do
    @user = create(:user)
    @card = create(:card, user: @user)
    @params = { card_id: @card.id }
  end


  it ".call should compare user text with original" do
    @params[:original_text] = 'run'
    interactor = CompareOriginText.call(params: @params)
    expect(interactor).to be_a_success
    @params[:original_text] = 'go'
    interactor = CompareOriginText.call(params: @params)
    expect(interactor).to_not be_a_success
  end
end
