class CompareOriginText
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
    check_correctness
  end

  def check_correctness
    if @card.original_text == @user_answer
      handle_answer true
      context.notice = notice('right')
    elsif allowable_error?
      handle_answer true
      context.notice = notice('guess')
    else
      handle_answer false
      context.notice = notice('false')
    end
  end

  def handle_answer(correct)
    @quality = count_quality(correct)
    if @card.updated_at.today?
      @card.update(quality: @quality)
    else
      update_params = CardNextReview.new(@card.repetition, @quality, @card.ef).calculate
      @card.update(update_params)
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

  def allowable_error?
    cost = Levenshtein.distance(@card.original_text, @user_answer)
    allow = ALLOWABLE_COSTS[cost] && ALLOWABLE_COSTS[cost].include?(@user_answer.length)
    allow ? true : false
  end

  def notice(correctness)
    case correctness
    when 'right'
      I18n.t('interactors.compare_text.right')
    when 'guess'
      I18n.t(
        'interactors.compare_text.guess',
        answer: @user_answer,
        original: @card.original_text,
        translated: @card.translated_text
      )
    when 'false'
      I18n.t('interactors.compare_text.wrong')
    end
  end
end
