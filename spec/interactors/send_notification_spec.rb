require 'rails_helper'

describe SendNotification do
  before(:all) do
    @user = create(:user)
    @deck = create(:deck, user: @user)
    @card = create(:card, user: @user, deck: @deck)
  end

  it "sends an email" do
    @card.update_attribute(:review_date, 1.day.ago)
    expect { SendNotification.call }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
