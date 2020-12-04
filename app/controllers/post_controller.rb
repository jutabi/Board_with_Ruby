# frozen_string_literal: true

class PostController < ApplicationController
  def write; end

  def create
    Post.create(member_id: current_member.id,
                member_nickname: current_member.nickname,
                like_count: 0,
                hate_count: 0,
                title: params[:title],
                content: params[:content])

    redirect_to '/'
  end

  def view
    @post = Post.find(params[:post_id])
  end

  def modify
    @post = Post.find(params[:post_id])
    if @post.member_id != current_member.id && current_member.user_role != 'ADMIN'
      redirect_back fallback_location: ''
    end
  end

  def update
    post = Post.find(params[:post_id])
    post.title = params[:title]
    post.content = params[:content]
    post.save

    redirect_to "/post/view/#{params[:post_id]}"
  end

  def remove
    post = Post.find(params[:post_id])
    if post.member_id == current_member.id || current_member.user_role == 'ADMIN'
      post.post_likes.each(&:delete)
      post.replies.each(&:delete)
      post.delete
      redirect_to '/'
    else
      redirect_back fallback_location: ''
    end
  end
end
