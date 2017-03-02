class Post < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :user
  has_many :comments, dependent: :destroy
end
