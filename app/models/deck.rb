class Deck < ActiveRecord::Base
  belongs_to :user
  has_many :cards
  validates :user, presence: true
  validates :name, presence: true
end
