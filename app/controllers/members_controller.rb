class MembersController < ApplicationController
  layout "top"
  #会員一覧
  def index
    @members = Member.order("number")
  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new(birthday: Date.new(1980 , 1 , 1))
  end

  def edit
    @member = Member.find(params[:id])
  end

  def create
  end

  def update
  end

  def destroy
  end

  def search
    @members = Member.search(params[:q] , params[:radio])
    render "index"
  end
end
