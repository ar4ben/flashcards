class CardNextReview
  def initialize(repetition, quality, ef_coeff)
    @repetition = repetition
    @quality = quality
    @ef = ef_coeff
  end

  def calculate
    @repetition = 1 if @quality < 3
    case @repetition
    when 1
      finalize(1.day, 2)
    when 2
      finalize(6.days, 3)
    else
      next_date = (@repetition - 1) * @ef
      finalize(next_date.round.days, @repetition + 1)
    end
  end

  def finalize(next_review, repetition)
    {
      review_date: next_review.since,
      repetition: repetition,
      ef: count_ef,
      quality: @quality
    }
  end

  def count_ef
    ef = if @quality < 3
           @ef
         else
           @ef + (0.1 - (5 - @quality) * (0.08 + (5 - @quality) * 0.02))
         end
    ef > 1.3 ? ef : 1.3
  end
end
