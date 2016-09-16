class CompareOriginText
  include Interactor

  def call
    card = Card.find(context.params[:card_id])
    if card.original_text == context.params[:original_text]
      card.update_column(:review_date, (DateTime.now + 3.days))
    else
      context.fail!
    end
  end
end
