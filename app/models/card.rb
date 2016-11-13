class Card < ActiveRecord::Base
  belongs_to :user
  validates :user, presence: true
  validates :original_text, presence: true
  validates :translated_text, presence: true
  validates :review_date, presence: true
  validate :translated_should_be_not_equal_to_original
  scope :random, ->(user_id) { where('review_date <= ? AND user_id = ?', Time.now, user_id).order("RANDOM()").limit(1) }

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
