class CompareOriginText
  include Interactor

  def call
    @card = Card.find(context.params[:card_id])
    @user_answer = context.params[:original_text].downcase.strip
    if @card.original_text == @user_answer
      correct_answer
      context.notice = "Правильно!"
    elsif cost_of_changing == 1
      correct_answer
      context.notice = "Судя по всему, под #{@user_answer} подразумевалось #{@card.original_text}.
                        Это правильный перевод для #{@card.translated_text}!"
    else
      incorrect_answer
      context.notice = "Неправильно!"
    end
  end

  def correct_answer
    @card.fail = 0
    @card.success = @card.success.to_i + 1
    case @card.success
    when 1
      update_rev 12.hours
    when 2
      update_rev 3.days
    when 3
      update_rev 1.week
    when 4
      update_rev 2.weeks
    else
      update_rev 1.month
    end
  end

  def incorrect_answer
    @card.fail = @card.fail.to_i + 1
    if @card.fail < 3
      @card.save
    else
      @card.success = 0
      update_rev 12.hours
    end
  end

  def update_rev(next_review)
    @card.update(
      review_date: next_review.since
    )
  end

  def cost_of_changing
    result = CalcLevenshteinDistance.call(
        original: @card.original_text,
        answer: @user_answer
    )
    result.cost
  end
end
