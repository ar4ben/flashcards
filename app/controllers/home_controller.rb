class HomeController < ApplicationController
  def index
    User.new_cards_notification
    result = GetRandomCard.call(
      params: { user_id: current_user.id }
    )
    @card = result.card
  end

  def check
    result = CompareOriginText.call(
      params: cards_params
    )
    redirect_to :back, notice: result.notice
  end

  private

  def cards_params
    params.require(:random_card).permit(:original_text, :card_id)
  end
end
