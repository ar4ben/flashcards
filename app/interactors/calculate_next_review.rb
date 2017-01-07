class CalculateNextReview
  include Interactor

  def call
    @card = Card.find(context.card)
    if context.success_attempt
      @card.fail = 0
      @card.success = @card.success.to_i + 1
      case @card.success
      when 1
        calculate 12.hours
      when 2
        calculate 3.days
      when 3
        calculate 1.week
      when 4
        calculate 2.weeks
      else
        calculate 1.month
      end
    else
      @card.fail = @card.fail.to_i + 1
      if @card.fail < 3
        @card.save
      else
        @card.success = 0
        calculate 12.hours
      end
      context.fail!
    end
  end

  private

  def calculate(next_rev)
    @card.update(
      review_date: DateTime.now + next_rev
    )
  end
end
