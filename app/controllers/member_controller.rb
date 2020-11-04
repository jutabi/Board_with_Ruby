# frozen_string_literal: true

class MemberController < ApplicationController
  def register; end

  def register_process
    Member.create(username: params[:username],
                  password: params[:password],
                  password_confirmation: params[:password_confirmation],
                  email: params[:email],
                  nickname: params[:nickname])

    redirect_to '/member/login'
  end

  def login; end

  def login_process
    member = Member.find_by(username: params[:username])
    if member&.authenticate(params[:password])
      log_in(member)
      redirect_to '/'
    else
      flash[:loginFail] = 'Invalid username or password'
      redirect_to '/member/login'
    end
  end

  def logout
    log_out
    redirect_to '/'
  end

  def modify
    @member = Member.find_by(username: session[:username])
    @member.password_digest = nil
  end

  def modify_process
    member = Member.find_by(username: session[:username])
    if member&.authenticate(params[:password])
      member.email = params[:email]
      member.nickname = params[:nickname]
      member.save
      redirect_to '/'
    else
      flash[:modifyFail] = 'Invalid password'
      redirect_back fallback_location: ''
    end
  end

  def withdrawal
    @member = Member.find_by(username: session[:username])
    @member.password_digest = nil
  end

  def withdrawal_process
    member = Member.find_by(username: session[:username])
    if member&.authenticate(params[:password])
      logout
      member.destroy
    else
      flash[:withdrawalFail] = 'Invalid password'
      redirect_back fallback_location: ''
    end
  end
end
