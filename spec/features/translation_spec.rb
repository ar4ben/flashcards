require 'rails_helper'

describe 'Translation check' do
  before(:each) do
    @card = create(:card)
    @card.update_attribute(:review_date, Time.now)
    visit root_path
  end

  context "with right original text" do
    it "should be success" do
      fill_in("random_card_original_text", with: "run")
      click_button "Проверить"
      expect(page).to have_content("Правильно!")
    end
  end

  context "with wrong original text" do
    it "should be failed" do
      fill_in("random_card_original_text", with: "бежать")
      click_button "Проверить"
      expect(page).to have_content("Неправильно!")
    end
  end
end
