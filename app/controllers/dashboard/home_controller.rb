class Dashboard::HomeController < ApplicationController
  def index
    rand_card
  end

  def check
    result = CompareOriginText.call(
      params: cards_params
    )
    respond_to do |format|
      format.html { redirect_to :back, notice: result.notice }
      format.js do
        rand_card
        flash.now[:notice] = result.notice
      end
    end
  end

  private

  def rand_card
    result = GetRandomCard.call(
      params: { user_id: current_user.id }
    )
    @card = result.card
  end

  def cards_params
    params.require(:random_card).permit(:original_text, :card_id, :time)
  end
end
