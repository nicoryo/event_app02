class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :messages, dependent: :destroy
  has_many :entries,  dependent: :destroy

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  has_many :hashtag_users, dependent: :destroy
  has_many :hashtags, through: :hashtag_users
#userをフォローする
  def follow(other_user)
    unless self == other_user
    self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

#userをフォローから外す
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

#フォローしているuserの中に自分自身がいたらTrueを返す
#フォロワーの関係性
  def following?(other_user)
    self.followings.include?(other_user)
  end

  validates :name,      presence: true
  validates :introduce, length: { maximum: 255 }
  validates :address,   length: { maximum: 50 }

  # ハッシュタグに関するアクション
  after_create do
      user = User.find_by(id: id)
      # hashbodyに打ち込まれたハッシュタグを検出
      hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
      hashtags.uniq.map do |hashtag|
        # ハッシュタグは先頭の#を外した上で保存
        tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
        user.hashtags << tag
      end
    end
    #更新アクション
    before_update do
      user = User.find_by(id: id)
      user.hashtags.clear
      hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
      hashtags.uniq.map do |hashtag|
        tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
        user.hashtags << tag
      end
    end
end
