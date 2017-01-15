require 'rails_helper'

describe Card, type: :model do
  before(:all) { @user = create(:user) }
  before(:all) { @deck = create(:deck, user: @user) }
  subject { described_class.new(original_text: 'run', translated_text: 'бежать', user: @user, deck: @deck) }

  context "when given attributtes" do
    it "is valid with valid attrs" do
      expect(subject).to be_valid
    end
  end

  context "#translated_should_be_not_equal_to_original" do
    it "has error when original and translated text are equal" do
      subject.translated_text = "example"
      subject.original_text = "example"
      subject.save
      expect(subject.errors[:translated_text]).to_not be_empty
    end
  end
end
