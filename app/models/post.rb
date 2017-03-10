class Post < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  def liked_by?(user)
    likes.find_by_user_id(user.id).present?
  end

  def like_for(user)
    likes.find_by(user: user)
  end
end
