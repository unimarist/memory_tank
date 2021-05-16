class QuestionsController < ApplicationController

  before_action :return_index
  before_action :find_tank, except: [:destroy,:check_a,:check_b,:check_c,:check_d]
  before_action :find_question, only: [:edit,:update,:delete_confirm]

  def index
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to tank_questions_path(@question.tank_id)
    else
      flash.now[:error_question] = "各項目は必須です。500字以内で入力して下さい。/Questionは未登録である必要があります。"
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(question_params) && @question.correct_rate >= 70
      redirect_to learned_tank_questions_path(@question.tank_id)
    elsif @question.update(question_params) && @question.correct_rate < 70
      redirect_to unlearned_tank_questions_path(@question.tank_id)
    else
      flash.now[:error_question] = "各項目は必須です。500字以内で入力して下さい。/Questionは未登録である必要があります。"
      render :edit
    end
  end

  def delete_confirm
  end

  def destroy
    question = Question.find(params[:id])
    tank = Tank.find(params[:tank_id])
    correct_rate = question.correct_rate
    question.destroy
    if correct_rate >= 70
      redirect_to learned_tank_questions_path(tank.id)
    else
      redirect_to unlearned_tank_questions_path(tank.id)
    end
  end

  def learned  
   @questions = Question.learned(params[:tank_id])
 end

 def unlearned  
   @questions = Question.unlearned(params[:tank_id])
 end

  def check_a
    question = Question.find(params[:id])
    calc(question,"A")
  end

  def check_b
    question = Question.find(params[:id])
    calc(question,"B")
  end

  def check_c
    question = Question.find(params[:id])
    calc(question,"C")
  end

  def check_d
    question = Question.find(params[:id])
    calc(question,"D")
  end

  private
  def return_index
    unless user_signed_in?
       redirect_to "/"
    end
  end

  def question_params
    params.require(:question).permit(:question,:answer_a,:answer_b,:answer_c,:answer_d,:correct_answer,:description,:correct_count,:uncorrect_count,:correct_rate).merge(user_id:current_user.id,tank_id:params[:tank_id])
  end

  def find_tank
    @tank = Tank.find(params[:tank_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def calc(question,choice_answer)
    if question.correct_answer == choice_answer
        question.increment(:correct_count, 1)
        sum = question.correct_count + question.uncorrect_count
        question.correct_rate = question.correct_count * 100  / sum if sum > 0
        question.save
        flash[:result] = "⭕️ 正解！：" + question.description
        flash[:target] = question.question
        if question.correct_rate>= 70
         redirect_to learned_tank_questions_path(question.tank_id, anchor: 'link')
        else
         redirect_to unlearned_tank_questions_path(question.tank_id, anchor: 'link')
        end
    else
        question.increment(:uncorrect_count, 1)
        sum = question.correct_count + question.uncorrect_count
        question.correct_rate = question.correct_count * 100  / sum if sum > 0
        question.save
        flash[:result] = "❌ 不正解！：" + question.description
        flash[:target] = question.question
        if question.correct_rate >= 70
         redirect_to learned_tank_questions_path(question.tank_id, anchor: 'link')
        else
         redirect_to unlearned_tank_questions_path(question.tank_id, anchor: 'link')
        end
    end
  end

end