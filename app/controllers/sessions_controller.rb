class SessionsController < ApplicationController
  def create
    member = Member.find_by(name: params[:name])
    if member&.authenticate(params[:password])
      # cookies[:member_id] = {value: member.id , expires: 15.seconds.from_now }
      cookies[:member_id] = {value: member.id}
    else
      flash.alert = "名前とパスワードが一致しません"
    end
    redirect_to :root
  end

  def destroy
    cookies.delete(:member_id)
    redirect_to :root
  end
end