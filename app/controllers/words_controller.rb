class WordsController < ApplicationController

  def index
    @tank = Tank.find_by(id: params[:tank_id])
  end

  def new
    @tank = Tank.find_by(id: params[:tank_id])
    @word = Word.new
  end

  def create
    word = Word.new(word_params)
    if word.save
      redirect_to tank_words_path(word.tank_id)
    else
      render :new
    end
  end

  def edit
    @word = Word.find_by(id: params[:id])
    @tank = Tank.find_by(id: params[:tank_id])
  end

  def update
    word = Word.find(params[:id])
    word.update(word_params)
    if word.correct_rate >= 70
    redirect_to learned_tank_words_path(word.tank_id)
    else
    redirect_to unlearned_tank_words_path(word.tank_id)
    end
  end

  def destroy
    word = Word.find(params[:id])
    tank = Tank.find_by(id: params[:tank_id])
    correct_rate = word.correct_rate
    word.destroy
    if correct_rate >= 70
      redirect_to learned_tank_words_path(tank.id)
      else
      redirect_to unlearned_tank_words_path(tank.id)
      end
  end

  def learned
    @words = Word.learned(params[:tank_id])
    @tank = Tank.find_by(id: params[:tank_id])
  end

  def unlearned  
    @words = Word.unlearned(params[:tank_id])
    @tank = Tank.find_by(id: params[:tank_id])
  end

  def correct_count
    word = Word.find(params[:id])
    correct_rate = word.correct_rate
    word.increment(:correct_count, 1)
    sum = word.correct_count + word.uncorrect_count
    word.correct_rate = word.correct_count * 100  / sum if sum > 0
    word.save
    if correct_rate >= 70
      redirect_to learned_tank_words_path(word.tank_id)
      else
      redirect_to unlearned_tank_words_path(word.tank_id)
      end
  end

  def uncorrect_count
    word = Word.find(params[:id])
    correct_rate = word.correct_rate
    word.increment(:uncorrect_count, 1)
    sum = word.correct_count + word.uncorrect_count
    word.correct_rate = word.correct_count * 100  / sum if sum > 0
    word.save
    if correct_rate >= 70
      redirect_to learned_tank_words_path(word.tank_id)
      else
      redirect_to unlearned_tank_words_path(word.tank_id)
      end
  end

  private
  def word_params
    params.require(:word).permit(:word,:meaning,:correct_count,:uncorrect_count,:correct_rate).merge(user_id:current_user.id,tank_id:params[:tank_id])
  end

end
