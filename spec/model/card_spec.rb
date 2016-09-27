require 'rails_helper'

describe Card, type: :model do
  subject { described_class.new(original_text: 'run', translated_text: 'бежать') }

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

  context "#set_review_date" do
    it "increase review date on 3 days more than now" do
      c = described_class.create(original_text: 'run', translated_text: 'бежать')
      review_day = c.review_date.strftime("%d")
      expected_day = (c.created_at + 3.days).strftime("%d")
      expect(review_day).to eq(expected_day)
    end
  end
end
