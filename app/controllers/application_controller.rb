class ApplicationController < ActionController::Base
  skip_forgery_protection
  include MemberHelper

  def login_authentication
    redirect_to 'member/login' unless member_logged_in?
  end

  def own_authentication(what)
    redirect_back fallback_location: '' if what.member_id != Member.find_by(username: session[:username])
  end
end
