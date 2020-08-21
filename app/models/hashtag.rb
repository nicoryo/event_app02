class Hashtag < ApplicationRecord
  validates :hashname, presence: true, length: { maximum: 50 }
  has_many :hashtag_users, dependent: :destroy
  has_many :users, through: :hashtag_users
end
