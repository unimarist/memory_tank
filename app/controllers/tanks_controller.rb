class TanksController < ApplicationController
  before_action :move_to_index, except: [:index]
  def index
  end

  def new
    @tank = Tank.new
    @id = params[:id]
  end

  def create
    @tank = Tank.new(tank_params)
    if @tank.save
      if @tank.tank_type == "単語"
      redirect_to word_search_tank_path(current_user.id)
      elsif @tank.tank_type == "問題"
      redirect_to question_search_tank_path(current_user.id)
      end
    else
      render :new
    end
  end

  def edit
    @tank = Tank.find(params[:id])
  end

  def update
    tank = Tank.find(params[:id])
    tank.update(tank_params)
    if tank.tank_type == "単語"
      redirect_to action: :word_search
    elsif tank.tank_type == "問題"
      redirect_to action: :question_search
    end
  end

  def destroy
    tank = Tank.find(params[:id])
    if tank.tank_type == "単語"
    tank.destroy
    redirect_to action: :word_search
    elsif tank.tank_type == "問題"
    tank.destroy
    redirect_to action: :question_search
    end
  end

  def word_search
    @tanks = Tank.word_search(current_user.id)
  end

  def question_search
    @tanks = Tank.question_search(current_user.id)
  end

  private
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def tank_params
    params.require(:tank).permit(:tank_name,:tank_type,:tank_icon).merge(user_id: current_user.id)
  end

end
