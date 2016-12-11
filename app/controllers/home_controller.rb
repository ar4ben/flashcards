class HomeController < ApplicationController
  def index
    result = GenerateRandomCard.call(params: { user_id: current_user.id })
    @card = result.card
  end

  def check
    result = CompareOriginText.call(
      params: cards_params
    )
    if result.success?
      redirect_to :back, notice: "Правильно!"
    else
      redirect_to :back, alert: "Неправильно!"
    end
  end

  private

  def cards_params
    params.require(:random_card).permit(:original_text, :card_id)
  end
end
