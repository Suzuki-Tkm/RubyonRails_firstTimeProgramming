class EntriesController < ApplicationController
  layout "top"
  def index
    if params[:member_id]
      @member = Member.find(params[:member_id])
      @entries = @member.entries
    else
      @entries = Entry.all
    end
    # @entries = @entries.readable_for(current_member).order(posted_at: :desc)
    @entries = @entries.readable_for(current_member)
      .order(posted_at: :desc).page(params[:page]).per(3)
  end

  def show
    @entry = Entry.readable_for(current_member).find(params[:id])
  end

  def new
    @entry = Entry.new(posted_at: Time.current)
  end

  def edit
    @entry = current_member.entries.find(params[:id])
  end

  def create
    @entry = Entry.new(params[:entry])
    @entry.author = current_member
    if @entry.save
      redirect_to @entry, notice: "記事を作成しました。"
    else
      render "new"
    end
  end

  def update
    @entry = current_member.entries.find(params[:id])
    @entry.assign_attributes(params[:entry])
    if @entry.save
      redirect_to @entry, notice: "記事を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @entry = current_member.entries.find(params[:id])
    @entry.destroy
    redirect_to :entries, notice: "記事を削除しました。"
  end

  def like
    @entry = Entry.published.find(params[:id])
    current_member.voted_entries << @entry
    redirect_to @entry, notice: "投票しました。"
  end

  def unlike
    current_member.voted_entries.destroy(Entry.find(params[:id]))
    redirect_to :voted_entries, notice: "削除しました。"
  end

  def voted
    if params[:id] == nil
      @entries = current_member.voted_entries.published.order("votes.created_at DESC").page(params[:page]).per(15)
    else
      @entries = Member.find(params[:id]).voted_entries.published.order("votes.created_at DESC").page(params[:page]).per(15)
    end
  end
end