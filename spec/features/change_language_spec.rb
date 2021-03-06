require 'rails_helper'

describe 'Language check' do
  context "when change locale" do
    it "should be rus" do
      visit dashboard_root_path
      expect(page).to have_content("Флешкарточкер")
    end

    it "should be en" do
      visit dashboard_root_path(locale: :en)
      expect(page).to have_content("Flashcarder")
    end
  end
end
