require 'rails_helper'

describe 'Card creation' do
  before(:each) do
    @user = create(:user)
    @deck = create(:deck, user: @user)
    login_user(@user, "password")
    visit new_dashboard_card_path
  end

  context "should work" do
    it "with image attachment" do
      fill_in("card_original_text", with: "run")
      fill_in("card_translated_text", with: "бежать")
      select @deck.name, from: "card_deck_id"
      attach_file("card_img", Rails.root + 'app/assets/images/missing.png')
      click_button "Отправить"
      expect(page).to have_xpath("//img[contains(@src,'/assets/missing')]")
    end

    it "with image url" do
      fill_in("card_original_text", with: "run")
      fill_in("card_translated_text", with: "бежать")
      select @deck.name, from: "card_deck_id"
      fill_in("card_img_remote_url", with: 'https://www.google.by/images/branding/googlelogo/2x/googlelogo_color_120x44dp.png')
      click_button "Отправить"
      expect(page).to have_xpath("//img[contains(@src,'googlelogo')]")
    end
  end
end
