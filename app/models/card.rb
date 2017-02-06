class Card < ActiveRecord::Base
  attr_reader :img_remote_url
  belongs_to :user
  belongs_to :deck
  validates :user, presence: true
  validates :deck, presence: true
  validates :original_text, presence: true
  validates :translated_text, presence: true
  validate :translated_should_be_not_equal_to_original
  before_create :set_review_date

  has_attached_file :img, styles: { medium: "360x360>", thumb: "100x100>" }, default_url: "missing.png"
  validates_attachment_content_type :img, content_type: %r{\Aimage\/.*\z}

  scope :random, -> { where('review_date <= ?', Time.now).order("RANDOM()").limit(1) }

  def img_remote_url=(url_value)
    if url_value.present?
      self.img = URI.parse(url_value)
      @img_remote_url = url_value
    end
  end

  protected

  def translated_should_be_not_equal_to_original
    if original_text.casecmp(translated_text).zero?
      errors.add(:translated_text, t('error.not_equal'))
    end
  end

  def set_review_date
    self.review_date = DateTime.now
  end
end
