class WordsController < ApplicationController

  before_action :return_index
  before_action :find_tank, except: [:destroy,:correct_count,:uncorrect_count]
  before_action :find_word, only: [:edit,:update,:delete_confirm]

  def index
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    if @word.save
      redirect_to tank_words_path(@word.tank_id)
    else
      flash.now[:error_word] = "「Word」は必須かつ未登録である必要があります。30字以内で入力して下さい。/「意味」は必須です。120文字以内で入力して下さい。"
      render :new
    end
  end

  def edit
  end

  def update
    if  @word.update(word_params) && @word.correct_rate >= 70
      redirect_to learned_tank_words_path(@word.tank_id)
    elsif @word.update(word_params) && @word.correct_rate < 70
      redirect_to unlearned_tank_words_path(@word.tank_id)
    else
      flash[:error_word] = "「Word」は必須かつ未登録である必要があります。30字以内で入力して下さい。/「意味」は必須です。120文字以内で入力して下さい。"
      render :edit
    end
  end

  def delete_confirm
  end

  def destroy
    tank = Tank.find(params[:tank_id])
    word = Word.find(params[:id])
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
  end

  def unlearned  
    @words = Word.unlearned(params[:tank_id])
  end

  def correct_count
    word = Word.find(params[:id])
    calc_type = "correct"
    calc(word,calc_type)
  end

  def uncorrect_count
    word = Word.find(params[:id])
    calc_type = "uncorrect"
    calc(word,calc_type)
  end

  def search
    search_key = params[:search_key]
    @word_level = params[:word_level]
    if @word_level == "未習得Word :" && (search_key.nil? || search_key == "")
      redirect_to unlearned_tank_words_path(params[:tank_id])
    elsif @word_level == "習得済Word :" && (search_key.nil? || search_key == "")
      redirect_to learned_tank_words_path(params[:tank_id])
    else
      @words = Word.search(params[:tank_id],search_key,@word_level)
    end
  end

  private
  def return_index
    unless user_signed_in?
      redirect_to "/"
    end
  end

  def word_params
    params.require(:word).permit(:word,:meaning,:correct_count,:uncorrect_count,:correct_rate).merge(user_id:current_user.id,tank_id:params[:tank_id])
  end

  def find_tank
    @tank = Tank.find(params[:tank_id])
  end

  def find_word
    @word = Word.find(params[:id])
  end

  def calc(word,calc_type)
    if calc_type == "correct"
      word.increment(:correct_count, 1)
      flash[:result] = "⭕️ 正解！" 
      flash[:target] = word.word
    elsif calc_type =="uncorrect"
      word.increment(:uncorrect_count, 1)
      flash[:result] = "❌ 不正解！" 
      flash[:target] = word.word
    end
    sum = word.correct_count + word.uncorrect_count
    word.correct_rate = word.correct_count * 100  / sum if sum > 0
    word.save
    if word.correct_rate >= 70
      redirect_to learned_tank_words_path(word.tank_id,anchor: 'link')
    else
      redirect_to unlearned_tank_words_path(word.tank_id,anchor: 'link')
    end
  end

end