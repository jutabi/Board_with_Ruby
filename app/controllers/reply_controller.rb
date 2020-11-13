class ReplyController < ApplicationController
  def create
    Reply.create(member_id: Member.find_by(username: session[:username]).id,
                 post_id: params[:post_id],
                 content: params[:content])

    # redirect_to '/post/view/' + params[:post_id]
    # redirect_back fallback_location: ''
    # @replies = Post.find(params[:post_id]).replies
    # redirect_to request.referer

    @post = Post.find(params[:post_id])
  end

  def read
    # @replies = Post.find(params[:post_id]).replies
    @post = Post.find(params[:post_id])
  end

  def update
    reply = Reply.find(params[:reply_id])
    post_id = reply.post_id
    if current_member.id == reply.member_id
      reply.content = params[:content]
      reply.save
    end

    @post = Post.find(post_id)
  end

  def remove
    reply = Reply.find(params[:reply_id])
    post_id = reply.post_id
    reply.delete if current_member.id == reply.member_id

    # redirect_to '/post/view/' + reply.post_id.to_s
    # redirect_back fallback_location: ''

    @post = Post.find(post_id)
  end
end
