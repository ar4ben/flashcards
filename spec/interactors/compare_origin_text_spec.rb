require 'rails_helper'
describe CompareOriginText do
  before do
    @card = Card.create(original_text: 'x', translated_text: 'y')
    @params = { card_id: @card.id }
  end

  it ".call should compare user text with original" do
    @params[:original_text] = 'x'
    interactor = CompareOriginText.call(params: @params)
    expect(interactor).to be_a_success
    @params[:original_text] = 'z'
    interactor = CompareOriginText.call(params: @params)
    expect(interactor).to_not be_a_success
  end
end
