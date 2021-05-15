class QuestionsController < ApplicationController

  def index
    @tank = Tank.find_by(id: params[:tank_id])
  end

  def new
    @tank = Tank.find_by(id: params[:tank_id])
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @tank = Tank.find_by(id: @question.tank_id)
    if @question.save
      redirect_to tank_questions_path(@question.tank_id)
    else
      flash.now[:error_question] = "各項目は必須です。500字以内で入力して下さい。/Questionは未登録である必要があります。"
      render :new
    end
  end

  def learned  
    @questions = Question.learned(params[:tank_id])
    @tank = Tank.find_by(id: params[:tank_id])
  end

  def unlearned  
    @questions = Question.unlearned(params[:tank_id])
    @tank = Tank.find_by(id: params[:tank_id])
  end

  def edit
    @question = Question.find_by(id: params[:id])
    @tank = Tank.find_by(id: params[:tank_id])
  end

  def update
    @question = Question.find(params[:id])
    @tank = Tank.find_by(id: @question.tank_id)
    if @question.update(question_params)
       if @question.correct_rate >= 70
           redirect_to learned_tank_questions_path(@question.tank_id)
       else
           redirect_to unlearned_tank_questions_path(@question.tank_id)
       end
    else
      flash.now[:error_question] = "各項目は必須です。500字以内で入力して下さい。/Questionは未登録である必要があります。"
      render :edit
    end
  end

  def delete_confirm
   @question = Question.find_by(id: params[:id])
   @tank = Question.find_by(id: params[:tank_id])
  end

  def destroy
    question = Question.find(params[:id])
    tank = Tank.find_by(id: params[:tank_id])
    correct_rate = question.correct_rate
    question.destroy
    if correct_rate >= 70
      redirect_to learned_tank_questions_path(tank.id)
      else
      redirect_to unlearned_tank_questions_path(tank.id)
      end
  end

  def check_a
    question = Question.find(params[:id])
    correct_answer = question.correct_answer
    if correct_answer == "A"
       question.increment(:correct_count, 1)
       sum = question.correct_count + question.uncorrect_count
       question.correct_rate = question.correct_count * 100  / sum if sum > 0
       question.save
       flash[:des] = "⭕️ 正解！：" + question.description
       flash[:com] = question.question
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
       flash[:des] = "❌ 不正解！：" + question.description
       flash[:com] = question.question
       if question.correct_rate >= 70
          redirect_to learned_tank_questions_path(question.tank_id, anchor: 'link')
       else
          redirect_to unlearned_tank_questions_path(question.tank_id, anchor: 'link')
       end
    end
  end


  def check_b
    question = Question.find(params[:id])
    correct_answer = question.correct_answer
    if correct_answer == "B"
       question.increment(:correct_count, 1)
       sum = question.correct_count + question.uncorrect_count
       question.correct_rate = question.correct_count * 100  / sum if sum > 0
       question.save
       flash[:des] = "⭕️ 正解！：" + question.description
       flash[:com] = question.question
       if question.correct_rate >= 70
          redirect_to learned_tank_questions_path(question.tank_id, anchor: 'link')
       else
          redirect_to unlearned_tank_questions_path(question.tank_id, anchor: 'link')
        end
    else
       question.increment(:uncorrect_count, 1)
       sum = question.correct_count + question.uncorrect_count
       question.correct_rate = question.correct_count * 100  / sum if sum > 0
       question.save
       flash[:des] = "❌ 不正解！：" + question.description
       flash[:com] = question.question
       if question.correct_rate >= 70
          redirect_to learned_tank_questions_path(question.tank_id, anchor: 'link')
       else
          redirect_to unlearned_tank_questions_path(question.tank_id, anchor: 'link')
       end
    end
  end


  def check_c
    question = Question.find(params[:id])
    correct_answer = question.correct_answer
    if correct_answer == "C"
       question.increment(:correct_count, 1)
       sum = question.correct_count + question.uncorrect_count
       question.correct_rate = question.correct_count * 100  / sum if sum > 0
       question.save
       flash[:des] = "⭕️ 正解！：" + question.description
       flash[:com] = question.question
       if question.correct_rate >= 70
          redirect_to learned_tank_questions_path(question.tank_id, anchor: 'link')
       else
          redirect_to unlearned_tank_questions_path(question.tank_id, anchor: 'link')
        end
    else
       question.increment(:uncorrect_count, 1)
       sum = question.correct_count + question.uncorrect_count
       question.correct_rate = question.correct_count * 100  / sum if sum > 0
       question.save
       flash[:des] = "❌ 不正解！：" + question.description
       flash[:com] = question.question
       if question.correct_rate >= 70
          redirect_to learned_tank_questions_path(question.tank_id, anchor: 'link')
       else
          redirect_to unlearned_tank_questions_path(question.tank_id, anchor: 'link')
       end
    end
  end

  def check_d
    question = Question.find(params[:id])
    correct_answer = question.correct_answer
    if correct_answer == "D"
       question.increment(:correct_count, 1)
       sum = question.correct_count + question.uncorrect_count
       question.correct_rate = question.correct_count * 100  / sum if sum > 0
       question.save
       flash[:des] = "⭕️ 正解！：" + question.description
       flash[:com] = question.question
       if question.correct_rate >= 70
          redirect_to learned_tank_questions_path(question.tank_id, anchor: 'link')
       else
          redirect_to unlearned_tank_questions_path(question.tank_id, anchor: 'link')
        end
    else
       question.increment(:uncorrect_count, 1)
       sum = question.correct_count + question.uncorrect_count
       question.correct_rate = question.correct_count * 100  / sum if sum > 0
       question.save
       flash[:des] = "❌ 不正解！：" + question.description
       flash[:com] = question.question
       if question.correct_rate >= 70
          redirect_to learned_tank_questions_path(question.tank_id, anchor: 'link')
       else
          redirect_to unlearned_tank_questions_path(question.tank_id, anchor: 'link')
       end
    end
  end



  private
  def question_params
    params.require(:question).permit(:question,:answer_a,:answer_b,:answer_c,:answer_d,:correct_answer,:description,:correct_count,:uncorrect_count,:correct_rate).merge(user_id:current_user.id,tank_id:params[:tank_id])
  end


end
