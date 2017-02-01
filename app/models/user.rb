class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :decks, dependent: :destroy
  belongs_to :deck
  has_many :cards, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  def self.new_cards_notification
    User.joins(:cards).where('review_date < ?', Time.now).group('id').each do |user|
      NotifyMailer.card_alarm(user)
    end
  end
end
