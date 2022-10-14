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
  end

  def edit
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
