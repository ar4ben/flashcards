class Dashboard::CardsController < ApplicationController
  before_action :set_card, only: [:edit, :show, :update, :destroy]

  def index
    @cards = current_user.cards.all
  end

  def new
    @card = current_user.cards.new
  end

  def edit
  end

  def create
    @card = current_user.cards.new(cards_params)
    if @card.save
      redirect_to [:dashboard, @card]
    else
      render 'new'
    end
  end

  def show
  end

  def update
    if @card.update(cards_params)
      redirect_to [:dashboard, @card]
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    redirect_to dashboard_cards_path
  end

  private

  def cards_params
    params.require(:card).permit(:original_text, :translated_text, :img_remote_url, :deck_id, :review_date)
  end

  def set_card
    @card = current_user.cards.find_by(id: params[:id])
    redirect_to dashboard_root_path unless @card
  end
end
