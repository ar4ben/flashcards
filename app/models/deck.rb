class Deck < ActiveRecord::Base
  belongs_to :user
  has_many :cards
  validates :user, presence: true
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :user_id
end
