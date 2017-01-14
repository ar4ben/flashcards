class GetRandomCard
  include Interactor

  def call
    current_user = User.find(context.params[:user_id])
    context.card = if current_user.deck_id
                     Deck.find(current_user.deck_id).cards.random.first
                   else
                     current_user.cards.random.first
                   end
  end
end
