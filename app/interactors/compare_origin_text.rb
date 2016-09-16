class CompareOriginText
  include Interactor

  def call
    card = Card.find(context.params[:card_id])
    user_answer = context.params[:original_text].downcase.strip
    if card.original_text == user_answer
      card.update_column(:review_date, (DateTime.now + 3.days))
    else
      context.fail!
    end
  end
end
