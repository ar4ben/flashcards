require 'rails_helper'

describe 'Translation check' do
  before(:each) do
    @user = create(:user)
    @deck = create(:deck, user: @user)
    @card = create(:card, user: @user, deck: @deck)
    @card.update_attribute(:review_date, Time.now)
    login_user(@user, "password")
    visit dashboard_root_path
  end

  context "with right original text" do
    it "should be success" do
      fill_in("random_card_original_text", with: @card.original_text)
      click_button "Отправить"
      expect(page).to have_content("Правильно!")
    end
  end

  context "with wrong original text" do
    it "should be failed" do
      fill_in("random_card_original_text", with: "бежать")
      click_button "Отправить"
      expect(page).to have_content("Неправильно!")
    end
  end
end
