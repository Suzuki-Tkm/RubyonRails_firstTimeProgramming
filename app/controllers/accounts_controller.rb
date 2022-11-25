class AccountsController < ApplicationController
  layout "top"
  before_action only: [:show , :edit , :update] do
    :login_required
  end

  def show
    @member = current_member
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    @member.assign_attributes(params[:account])
    if @member.save
      redirect_to :account, notice: "アカウント情報を更新しました。"
    else
      render "edit"
    end
  end

  def new
    @member = Member.new(birthday: Date.new(1980 , 1 , 1))
  end

  def create
    @member = Member.new(params[:member])
    if @member.save
      redirect_to :root , notice: "会員を登録しました。"
    else
      render "new"
    end
  end
end