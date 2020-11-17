class Post < ApplicationRecord
  belongs_to :member
  has_many :replies
  has_many :post_likes
  has_many :liked_members, through: :post_likes, source: :member
end
