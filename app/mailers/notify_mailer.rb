class NotifyMailer < ApplicationMailer
  def card_alarm(user)
    @user = user
    mail(to: @user.email, subject: 'Есть доступные карты')
  end
end
