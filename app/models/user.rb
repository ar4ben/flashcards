class User < ActiveRecord::Base
  has_many :cards
  validates :email, presence: true
  validates :password, presence: true
end
