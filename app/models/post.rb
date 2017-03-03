class Post < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :likes, dependant: :destroy
  has_many :users, through: :likes
end
