class LikeController < ApplicationController
  def like_toggle
    post = Post.find(params[:post_id])

    if current_member.is_like?(post).nil? # 좋아요 생성
      PostLike.create(member_id: current_member.id,
                      post_id: params[:post_id],
                      like_or_hate: true)
      post.like_count += 1
      post.save
    elsif current_member.is_like?(post) == true # 좋아요 취소
      ps = PostLike.find_by(member_id: current_member.id)
      ps.like_or_hate = nil
      ps.save

      post.like_count -= 1
      post.save
    elsif current_member.is_like?(post) == false # 싫어요 취소, 좋아요 추가
      ps = PostLike.find_by(member_id: current_member.id)
      ps.like_or_hate = true
      ps.save

      post.hate_count -= 1
      post.like_count += 1
      post.save
    elsif current_member.is_like?(post) == 'no_data' # 테이블 데이터는 있지만 취소했었던 경우
      ps = PostLike.find_by(member_id: current_member.id)
      ps.like_or_hate = true
      ps.save

      post.like_count += 1
      post.save
    end

    redirect_to "/post/view/#{params[:post_id]}"
  end

  def hate_toggle
    post = Post.find(params[:post_id])

    if current_member.is_like?(post).nil? # 싫어요 생성
      PostLike.create(member_id: current_member.id,
                      post_id: params[:post_id],
                      like_or_hate: false)
      post.hate_count += 1
      post.save
    elsif current_member.is_like?(post) == false # 싫어요 취소
      ps = PostLike.find_by(member_id: current_member.id)
      ps.like_or_hate = nil
      ps.save

      post.hate_count -= 1
      post.save
    elsif current_member.is_like?(post) == true # 좋아요 취소, 싫어요 추가
      ps = PostLike.find_by(member_id: current_member.id)
      ps.like_or_hate = false
      ps.save

      post.like_count -= 1
      post.hate_count += 1
      post.save
    elsif current_member.is_like?(post) == 'no_data' # 기록은 있지만 취소했었던 경우
      ps = PostLike.find_by(member_id: current_member.id)
      ps.like_or_hate = false
      ps.save

      post.hate_count += 1
      post.save
    end

    redirect_to "/post/view/#{params[:post_id]}"
  end
end
