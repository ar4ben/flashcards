class SendNotification
  include Interactor

  def call
    User.joins(:cards).where('review_date < ?', Time.now).group('id').each do |user|
      NotifyMailer.card_alarm(user).deliver_now
    end
  end
end
