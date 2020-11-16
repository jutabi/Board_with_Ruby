# frozen_string_literal: true

class PostController < ApplicationController
  def write; end

  def create
    member = Member.find_by(username: session[:username])
    Post.create(member_id: member.id,
                member_nickname: member.nickname,
                title: params[:title],
                content: params[:content])

    redirect_to '/'
  end

  def view
    @post = Post.find(params[:post_id])
  end

  def modify
    @post = Post.find(params[:post_id])
    if Post.find(params[:post_id]).member_id != Member.find_by(username: session[:username]).id
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
    if post.member_id == Member.find_by(username: session[:username]).id
      post.delete
      redirect_to '/'
    else
      redirect_back fallback_location: ''
    end
  end
end
