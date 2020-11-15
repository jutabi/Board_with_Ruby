# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    # @posts = Post.all.reverse_order

    # 첫 5개 -> (0,1,2,3,4)
    # @posts = Post.limit(5).reverse_order

    start_index = if params[:current_page].nil?
                    0
                  else
                    # params[:current_page].to_i * 5
                    Integer(params[:current_page]) * 5
                  end

    @posts_count = Post.count

    unless params[:current_page].nil?
      if Integer(params[:current_page]).negative?
        redirect_to '/'
      elsif Integer(params[:current_page]) > @posts_count / 5
        redirect_to "/#{@posts_count / 5}"
      end
    end
    # 첫 offset 개를 빼고 5개 -> (0,1 빼고 2,3,4,5,6)
    @posts = Post.limit(5).offset(start_index)
  end
end
