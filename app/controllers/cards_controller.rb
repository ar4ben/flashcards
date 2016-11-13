class CardsController < ApplicationController
  before_action :check_user, only: [:edit, :show, :update, :destroy]

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
      redirect_to @card
    else
      render 'new'
    end
  end

  def show
  end

  def update
    if @card.update(cards_params)
      redirect_to @card
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  private

  def cards_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end

  def check_user
    @card = Card.find(params[:id])
    redirect_to root_path if @card.user.id != current_user.id
  end
end
