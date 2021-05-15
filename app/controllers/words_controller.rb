class WordsController < ApplicationController

  def index
    @tank = Tank.find_by(id: params[:tank_id])
  end

  def new
    @tank = Tank.find_by(id: params[:tank_id])
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    @tank = Tank.find_by(id: @word.tank_id)
    if @word.save
      redirect_to tank_words_path(@word.tank_id)
    else
      flash.now[:error_word] = "「Word」は必須かつ未登録である必要があります。30字以内で入力して下さい。/「意味」は必須です。120文字以内で入力して下さい。"
      render :new
    end
  end

  def edit
    @word = Word.find_by(id: params[:id])
    @tank = Tank.find_by(id: params[:tank_id])
  end

  def update
    @word = Word.find(params[:id])
    @tank = Tank.find_by(id: @word.tank_id)
   if  @word.update(word_params)
     if @word.correct_rate >= 70
        redirect_to learned_tank_words_path(@word.tank_id)
      else
        redirect_to unlearned_tank_words_path(@word.tank_id)
      end
    else
      flash[:error_word] = "「Word」は必須かつ未登録である必要があります。30字以内で入力して下さい。/「意味」は必須です。120文字以内で入力して下さい。"
      render :edit
    end
  end

  def delete_confirm
    @word = Word.find_by(id: params[:id])
    @tank = Tank.find_by(id: params[:tank_id])
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
    @words = Word.includes(:tank,:user).learned(params[:tank_id])
    @tank = Tank.includes(:user).find_by(id: params[:tank_id])
  end

  def unlearned  
    @words = Word.unlearned(params[:tank_id])
    @tank = Tank.find_by(id: params[:tank_id])
  end

  def correct_count
    word = Word.find_by(id: params[:id])
    word.increment(:correct_count, 1)
    flash[:des] = "⭕️ 正解！" 
    flash[:com] = word.word
    sum = word.correct_count + word.uncorrect_count
    word.correct_rate = word.correct_count * 100  / sum if sum > 0
    word.save
    if word.correct_rate >= 70
      redirect_to learned_tank_words_path(word.tank_id,anchor: 'link')
      else
      redirect_to unlearned_tank_words_path(word.tank_id,anchor: 'link')
      end
  end

  def uncorrect_count
    word = Word.find(params[:id])
    word.increment(:uncorrect_count, 1)
    sum = word.correct_count + word.uncorrect_count
    word.correct_rate = word.correct_count * 100  / sum if sum > 0
    word.save
    flash[:des] = "❌ 不正解！" 
    flash[:com] = word.word
    if word.correct_rate >= 70
      redirect_to learned_tank_words_path(word.tank_id)
      else
      redirect_to unlearned_tank_words_path(word.tank_id)
      end
  end

  def search
    id = params[:tank_id]
    @tank = Tank.find_by(id: id)  
    key = params[:key]
    @word_level = params[:correct_rate]

    if @word_level == "未習得Word :" && (key.nil? || key == "")
      redirect_to unlearned_tank_words_path(id)
     elsif @word_level == "習得済Word :" && (key.nil? || key == "")
      redirect_to learned_tank_words_path(id)
     else
      @words = Word.search(id,key,@word_level)
     end
  end


  private
  def word_params
    params.require(:word).permit(:word,:meaning,:correct_count,:uncorrect_count,:correct_rate).merge(user_id:current_user.id,tank_id:params[:tank_id])
  end

end
