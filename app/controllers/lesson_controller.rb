class LessonController < ApplicationController
  def step1
    render plain: "こんにちは、#{params[:name]}さん"
  end

  def step2
    render plain: params[:controller] + "#" + params[:action]
  end

  def step3
    redirect_to action: "step4"
  end

  def step4
    render plain: "step4に移動しました。"
  end

  def step5
    flash[:notice] = "step6に移動します。"
    redirect_to action: "step6"
  end

  def step6
    render plain: flash[:notice]
  end

  def step7
    @price = (2000 * 1.08).floor
  end

  def step8
    @price = 1000
    render "step7"
  end

  def step9
    @comment = "<script>alert('危険！')</script>こんにちは。"
  end

  def step10
    @comment = "<strong>安全なHTML</strong>"
  end

  def step11
    @population = 704414
    @surface = 141.31
  end

  def step12
    @time = Time.current
  end

  def step13
    @population = 127767944
  end

  def step14
    @message = "ごきげんいかが？\nRailsの勉強を頑張りましょう。"
  end

  def step17
    @zaiko = 10
  end

  def step18
    @items = {
      "フライパン" => 2680 , 
      "ワイングラス" => 2550 ,
      "ペッパーミル" => 4515 ,
      "ピーラー" => 945
    }
  end

  def step19
    # @name = params[:name]
  end

  def step20
    @price = params[:price].to_i
  end

  def add
    begin
      @n = Integer(params[:n])
      @m = Integer(params[:m])
    rescue => exception
      flash[:notice] = "数値を指定してください。"
      redirect_to action: "error"
    end
  end

  def error
  end

  def db_practice
    # @members = Member.where(name: "Taro").where("number < 20")
    # @members = Member.where(sex: 2).order(number: :desc)
    # @members = Member.where(sex: 2).order(number: :desc).first
  end
end
