class PostLike < ApplicationRecord
  belongs_to :member
  belongs_to :post
  # belongs_to :post, counter_cache: true
end
