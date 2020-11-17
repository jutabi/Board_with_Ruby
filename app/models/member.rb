# frozen_string_literal: true

class Member < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :replies
  has_many :post_likes
  has_many :liked_posts, through: :post_likes, source: :post

  def is_like?(post)
    ps = PostLike.find_by(member_id: self, post_id: post.id)
    if ps.present?
      case ps.like_or_hate
      when true
        true
      when false
        false
      when nil
        'no_data'
      end
    end
  end
end
