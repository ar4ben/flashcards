require "rails_helper"

RSpec.describe NotifyMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:deck) { create(:deck, user: user) }
  let(:card) { create(:card, user: user, deck: deck) }
  let(:mail) { described_class.card_alarm(user).deliver_now }

  it 'renders the subject' do
    expect(mail.subject).to eq('Есть доступные карты')
  end
end
