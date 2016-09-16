class Card < ActiveRecord::Base
  validates :original_text, presence: true
  validates :translated_text, presence: true
  validates :review_date, presence: true
  validate :translated_should_be_not_equal_to_original
  scope :random, -> { where('review_date <= ?', Time.now).order("RANDOM()").first }

  before_validation :set_review_date

  protected

  def translated_should_be_not_equal_to_original
    if original_text.downcase == translated_text.downcase
      errors.add(:translated_text, "перевод не может быть равен начальному тексту")
    end
  end

  def set_review_date
    self.review_date = DateTime.now + 3.days
  end
end
