class HomeController < ApplicationController
  before_action :set_card, only: [:check]

  def index
    @card = Card.random
  end

  def check
    if original_equal?
      right
    else
      wrong
    end
  end

  private

  def cards_params
    params.require(:random_card).permit(:original_text, :card_id)
  end

  def set_card
    @card = Card.find(cards_params[:card_id])
  end

  def original_equal?
    @card.original_text == cards_params[:original_text]
  end

  def right
    @card.update_column(:review_date, (DateTime.now + 3.days))
    redirect_to :back, notice: "Правильно!"
  end

  def wrong
    redirect_to :back, alert: "Неправильно!"
  end
end
