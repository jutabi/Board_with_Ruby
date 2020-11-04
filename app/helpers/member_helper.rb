module MemberHelper
  def log_in(member)
    session[:username] = member.username
  end

  def log_out
    session.delete(:username)
    @current_member = nil
  end

  def current_member
    if @current_member.nil? && member_logged_in?
      member = Member.find_by(username: session[:username])
      member.password_digest = nil
      @current_member = member
    else
      @current_member
    end
  end

  def member_logged_in?
    # !current_member.nil?
    !session[:username].nil?
  end

  def find_nickname(id)
    Member.find(id).nickname
  end
end
