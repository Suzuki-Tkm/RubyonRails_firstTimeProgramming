class Admin::MembersController < Admin::Base
  layout "top"
  #会員一覧
  def index
    @members = Member.order("number")
      .page(params[:page]).per(15)
    @duties = Duty.all
  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new(birthday: Date.new(1980 , 1 , 1))
  end

  def edit
    @member = Member.find(params[:id])
    @duties = @member.duties
  end

  def create
    @member = Member.new(params[:member])
    if @member.save
      redirect_to [:admin, @member], notice: "会員を登録しました。"
    else
      render "new"
    end
  end

  def update
    @member = Member.find(params[:id])
    @member.assign_attributes(params[:member])
    if @member.save
      redirect_to [:admin, @member], notice: "会員情報を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to :admin_members, notice: "会員を削除しました。"
  end

  def search
    @members = Member.search(params[:q] , params[:radio])
      .page(params[:page]).per(15)
    render "index"
  end
end