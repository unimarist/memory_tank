class TanksController < ApplicationController

  before_action :return_index, except: [:index]
  before_action :find_tank, only: [:edit, :update, :delete_confirm]

  def index
  end

  def word_tank_index
    @tanks = Tank.word_tank_search(current_user.id)
  end

  def question_tank_index
    @tanks = Tank.question_tank_search(current_user.id)
  end

  def new
    @tank = Tank.new
    @tank_type = params[:tank_type]
  end

  def create
    @tank = Tank.new(tank_params)
    if  @tank.save && @tank.tank_type == "単語"
        redirect_to word_tank_index_tank_path(current_user.id)
    elsif @tank.save && @tank.tank_type == "問題"
        redirect_to question_tank_index_tank_path(current_user.id)
    elsif @tank.tank_type == "単語"
        @tank_type = "単語"
        render_new
    else
        @tank_type = "問題"
        render_new
    end
  end

  def edit
  end

  def update
    if  @tank.update(tank_params) && @tank.tank_type == "単語"
        redirect_to word_tank_index_tank_path(current_user.id)
    elsif @tank.update(tank_params) && @tank.tank_type == "問題"
        redirect_to question_tank_index_tank_path(current_user.id)
    elsif @tank.tank_type == "単語"
        @tank_type = "単語"
        render_edit
    else
        @tank_type = "問題"
        render_edit
    end
  end

  def delete_confirm
  end

  def destroy
    tank = Tank.find(params[:id])
    if tank.tank_type == "単語"
        tank.destroy
        redirect_to word_tank_index_tank_path(current_user.id)
    elsif tank.tank_type == "問題"
        tank.destroy
        redirect_to question_tank_index_tank_path(current_user.id)
    end
  end

  private
  def return_index
    unless user_signed_in?
        redirect_to action: :index
    end
  end

  def tank_params
    params.require(:tank).permit(:tank_name,:tank_type,:tank_icon).merge(user_id: current_user.id)
  end

  def find_tank
    @tank = Tank.find(params[:id])
  end

  def render_new
    flash.now[:error_tank] = "「Tank名」は必須です。30字以内で入力して下さい。" 
    render :new
  end

  def render_edit
    flash.now[:error_tank] = "「Tank名」は必須です。30字以内で入力して下さい。" 
    render :edit
  end

end