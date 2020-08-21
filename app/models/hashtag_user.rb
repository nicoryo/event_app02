class HashtagUser < ApplicationRecord
  belongs_to :user
  belongs_to :hashtag
  validates  :user_id, presence: true
  validates  :hashtag_id, presence: true
end
