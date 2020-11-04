class Post < ApplicationRecord
  belongs_to :member
  has_many :replies
end
