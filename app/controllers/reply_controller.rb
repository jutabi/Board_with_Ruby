class ReplyController < ApplicationController
  def create
    Reply.create(member_id: Member.find_by(username: session[:username]).id,
                 post_id: params[:post_id],
                 content: params[:content])

    # redirect_to '/post/view/' + params[:post_id]
    redirect_back fallback_location: ''
  end

  def update
    reply = Reply.find(params[:reply_id])
    if current_member.id == reply.member_id
      reply.content = params[:content]
      reply.save
    end

    redirect_back fallback_location: ''
  end

  def remove
    reply = Reply.find(params[:reply_id])
    reply.delete if current_member.id == reply.member_id

    # redirect_to '/post/view/' + reply.post_id.to_s
    redirect_back fallback_location: ''
  end
end
