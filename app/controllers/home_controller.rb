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
    print(params[:current_page])
    print(start_index: start_index)
    # 첫 offset 개를 빼고 5개 -> (0,1 빼고 2,3,4,5,6)
    @posts = Post.limit(5).offset(start_index)

    @posts_count = Post.count
  end
end
