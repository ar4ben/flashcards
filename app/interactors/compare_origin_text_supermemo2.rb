class CompareOriginTextSupermemo2
  include Interactor
  include Levenshtein

  ALLOWABLE_COSTS = {
    1 => 5..9,
    2 => 10..14,
    3 => 14..20,
    4 => 21..50
  }.freeze

  def call
    @card = Card.find(context.params[:card_id])
    @user_answer = context.params[:original_text].downcase.strip
    @time = context.params[:time].to_i
    if @card.original_text == @user_answer
      handle_answer true
      context.notice = I18n.t('interactors.compare_text.right')
    elsif allowable_error?
      handle_answer true
      context.notice = I18n.t('interactors.compare_text.guess',
                              answer: @user_answer,
                              original: @card.original_text,
                              translated: @card.translated_text)

    else
      handle_answer false
      context.notice = I18n.t('interactors.compare_text.wrong')
    end
  end

  def handle_answer(correct)
    @quality = count_quality(correct)
    if @card.updated_at.today?
      update_quality
    else
      count_next_date
    end
  end

  def count_quality(correct)
    case @time
    when 0..10
      correct ? 5 : 2
    when 10..20
      correct ? 4 : 1
    else
      correct ? 3 : 0
    end
  end

  def count_next_date
    @card.repetition = 1 if @quality < 3
    case @card.repetition
    when 1
      update_rev(1.day, 2)
    when 2
      update_rev(6.days, 3)
    else
      next_date = (@card.repetition - 1) * @card.ef
      update_rev(next_date.round.days, @card.repetition + 1)
    end
  end

  def update_rev(next_review, repetition)
    @card.update(
      review_date: next_review.since,
      repetition: repetition,
      ef: count_ef,
      quality: @quality
    )
  end

  def count_ef
    ef = if @quality < 3
           @card.ef
         else
           @card.ef + (0.1 - (5 - @quality) * (0.08 + (5 - @quality) * 0.02))
         end
    ef > 1.3 ? ef : 1.3
  end

  def update_quality
    @card.update(quality: @quality)
  end

  def allowable_error?
    cost = Levenshtein.distance(@card.original_text, @user_answer)
    allow = ALLOWABLE_COSTS[cost] && ALLOWABLE_COSTS[cost].include?(@user_answer.length)
    allow ? true : false
  end
end
