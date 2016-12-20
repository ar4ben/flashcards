class CardsController < ApplicationController
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
    p = params.require(:card).permit(:original_text, :translated_text, :img_remote_url, :deck_id)
    date_arr = Array.new(3) { |i| :"review_date(#{i + 1}i)" }
    raw_review = params["review"] ? params.require(:review).permit(*date_arr) : nil
    if raw_review
      review = raw_review.values.map(&:to_i)
      p.merge(review_date: Date.new(*review))
    else
      p
    end
  end

  def set_card
    @card = current_user.cards.find_by(id: params[:id])
    redirect_to root_path unless @card
  end
end
