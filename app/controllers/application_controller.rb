class ApplicationController < ActionController::Base
  before_action :update_expiration_time
  
  private def current_member
    Member.find_by(id: cookies[:member_id]) if cookies[:member_id]
  end
  helper_method :current_member

  class LoginRequired < StandardError; end
  class Forbidden < StandardError; end

  private def login_required
    raise LoginRequired unless current_member
  end

  private def update_expiration_time
    cookies[:member_id] = {value: cookies[:member_id] , expires: 15.seconds.from_now } if cookies[:member_id]
  end
end
