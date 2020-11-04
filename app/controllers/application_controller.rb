class ApplicationController < ActionController::Base
  skip_forgery_protection
  include MemberHelper

  def login_authentication
    redirect_to 'member/login' unless member_logged_in?
  end
end
