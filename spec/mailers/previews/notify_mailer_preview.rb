# Preview all emails at http://localhost:3000/rails/mailers/notify_mailer
class NotifyMailerPreview < ActionMailer::Preview
  def card_alarm
    NotifyMailer.card_alarm(User.first)
  end
end
