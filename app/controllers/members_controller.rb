class MembersController < ApplicationController
  layout "top"
  before_action :login_required
  #会員一覧
  def index
    @members = Member.order("number")
      .page(params[:page]).per(15)
    @duties = Duty.all
  end

  def show
    @member = Member.find(params[:id])
  end

  def search
    @members = Member.search(params[:q] , params[:radio])
      .page(params[:page]).per(15)
    render "index"
  end
end