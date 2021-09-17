require 'rails_helper'

RSpec.describe 'Question作成', type: :system, js: true do
  before do
    @tank = FactoryBot.create(:tank)  
    @tank.tank_type = "問題"
    @tank.save
    @question = Faker::Lorem.characters(number: 500)
    @answer_a = Faker::Lorem.characters(number: 500)
    @answer_b = Faker::Lorem.characters(number: 500)
    @answer_c = Faker::Lorem.characters(number: 500)
    @answer_d = Faker::Lorem.characters(number: 500)
    @correct_answer = Faker::Lorem.characters(number: 1)
    @description = Faker::Lorem.characters(number: 500)
      
  end
  context '【正常系】Question登録_成功'do
  it 'ログインしたユーザーでQuestionを登録する場合' do
    # Tankを作成したユーザーでログインする
    sign_in(@tank.user)
    # QuestionTank一覧ページへ遷移するアイコンをクリックする
    find("img[src$='tank_img_2.jpg']").click
    # QuestionTank一覧ページへ遷移したことを確認する
    expect(current_path).to eq question_tank_index_tank_path(@tank.user_id)
    # QuestionTankページへ遷移するアイコンをクリックする
    find("img[src$='tank_img_2.jpg']").click
    # Question登録ページへのリンクがあることを確認する
    expect(page).to have_content('Questionを登録する')
    # Question登録ページに移動する
    visit new_tank_question_path(@tank.id)
    # Questionを入力する
    fill_in 'question_question', with: @question
    # 解答選択肢_Aを入力する
    fill_in 'question_answer_a', with: @answer_a
    # 解答選択肢_Bを入力する
    fill_in 'question_answer_b', with: @answer_b
    # 解答選択肢_Cを入力する
    fill_in 'question_answer_c', with: @answer_c
    # 解答選択肢_Dを入力する
    fill_in 'question_answer_d', with: @answer_d
    # 正解選択肢を指定する
    choose 'question_correct_answer_a'
    # 解説を入力する
    fill_in 'question_description', with: @description
    # 送信するとQuestionモデルのカウントが1上がることを確認する
    expect{
    find('input[name="commit"]').click
    }.to change { Question.count }.by(1)
    # QuestionTankページへ遷移することを確認する
    expect(current_path).to eq tank_questions_path(@tank.id)
    # 未習得Tankページへ遷移するアイコンをクリックする
    find("img[src$='/images/down.jpg']").click
    # 未習得Tankページに先ほど作成したQuestionのquestionが存在することを確認する
    expect(page).to have_content(@question)
    # 未習得Tankページに先ほど作成した解答選択肢_Aが存在することを確認する
    expect(page).to have_content(@answer_a)
    # 未習得Tankページに先ほど作成した解答選択肢_Bが存在することを確認する
    expect(page).to have_content(@answer_b)
    # 未習得Tankページに先ほど作成した解答選択肢_Cが存在することを確認する
    expect(page).to have_content(@answer_c)
    # 未習得Tankページに先ほど作成した解答選択肢_Dが存在することを確認する
    expect(page).to have_content(@answer_d)
  end
  end
  context '【異常系】Question登録_失敗'do
  it 'ユーザがログインしていない場合' do
     # Question登録ページへ遷移する
     visit new_tank_question_path(@tank.id)
     # 登録ページへ遷移せず、トップページに戻ったことを確認する
     expect(current_path).to eq root_path
  end
  end
end


RSpec.describe 'Question編集', type: :system, js: true do
  before do
    @question = FactoryBot.create(:question)
    @question.correct_rate = @question.correct_count * 100 / (@question.correct_count + @question.uncorrect_count)
    @question.save
    @tank = @question.tank  
    @tank.tank_type = "問題"
    @tank.tank_name = "test"
    @tank.user_id = @question.user.id
    @tank.save
  end
  context '【正常系】Question編集_成功' do
    it 'ログインしたユーザーでQuestionを編集する場合' do
      # Questionを作成したユーザーでログインする
      sign_in(@question.user)
      # QuestionTank一覧ページへ遷移するアイコンをクリックする
      find("img[src$='tank_img_2.jpg']").click
      # QuestionTankページへ遷移するアイコンをクリックする
      find("img[src$='tank_img_2.jpg']").click
     if @question.correct_rate < 70
       # 未習得Tankページへ遷移するアイコンをクリックする
       find("img[src$='/images/down.jpg']").click
       # Question編集ページへのリンクがあることを確認する
       expect(page).to have_content('編集') 
       # 編集ページへ遷移する
       visit edit_tank_question_path(@tank.id,@question.id)
       # すでに作成済みの内容がフォームに入っていることを確認する
       expect(
         find('#question_question').value 
       ).to eq @question.question
       expect(
         find('#question_answer_a').value 
       ).to eq @question.answer_a
       expect(
        find('#question_answer_b').value 
       ).to eq @question.answer_b
       expect(
        find('#question_answer_c').value 
       ).to eq @question.answer_c
       expect(
        find('#question_answer_d').value 
       ).to eq @question.answer_d
       expect(
        find('#question_correct_answer_a').value 
       ).to eq 'A'
       expect(
        find('#question_description').value 
       ).to eq @question.description
       # 投稿内容を編集する
       fill_in 'question_question', with: "編集"
       # 解答選択肢_Aを編集する
       fill_in 'question_answer_a', with: "編集"
       # 解答選択肢_Bを編集する
       fill_in 'question_answer_b', with: "編集"
       # 解答選択肢_Cを編集する
       fill_in 'question_answer_c', with: "編集"
       # 解答選択肢_Dを編集する
       fill_in 'question_answer_d', with: "編集"
       # 正解選択肢を指定する
       choose 'question_correct_answer_b'
       # 解説を編集する
       fill_in 'question_description', with: "編集"
       # 編集してもQuestionモデルのカウントは変わらないことを確認する
       expect{
         find('input[name="commit"]').click
       }.to change { Question.count }.by(0)
       # 未習得Tankページに遷移することを確認する
       expect(current_path).to eq unlearned_tank_questions_path(@tank.id) 
       # 未習得Tankページに先ほど編集したQuestionのquestionが存在することを確認する
       expect(page).to have_content("編集")
       # 未習得Tankページに先ほど編集した解答選択肢_Aが存在することを確認する
       expect(page).to have_content("編集")
       # 未習得Tankページに先ほど編集した解答選択肢_Bが存在することを確認する
       expect(page).to have_content("編集")
       # 未習得Tankページに先ほど編集した解答選択肢_Cが存在することを確認する
       expect(page).to have_content("編集")
       # 未習得Tankページに先ほど編集した解答選択肢_Dが存在することを確認する
       expect(page).to have_content("編集")
     else
        # 習得済Tankページへ遷移するアイコンをクリックする
        find("img[src$='/images/up.jpg']").click
        #  Question編集ページへのリンクがあることを確認する
        expect(page).to have_content('編集') 
        # 編集ページへ遷移する
        visit edit_tank_question_path(@tank.id,@question.id)
        # すでに作成済みの内容がフォームに入っていることを確認する
        expect(
          find('#question_question').value 
        ).to eq @question.question
        expect(
          find('#question_answer_a').value 
        ).to eq @question.answer_a
        expect(
         find('#question_answer_b').value 
        ).to eq @question.answer_b
        expect(
         find('#question_answer_c').value 
        ).to eq @question.answer_c
        expect(
         find('#question_answer_d').value 
        ).to eq @question.answer_d
        expect(
         find('#question_correct_answer_a').value 
        ).to eq 'A'
        expect(
         find('#question_description').value 
        ).to eq @question.description
        # 投稿内容を編集する
        fill_in 'question_question', with: "編集"
        # 解答選択肢_Aを編集する
        fill_in 'question_answer_a', with: "編集"
        # 解答選択肢_Bを編集する
        fill_in 'question_answer_b', with: "編集"
        # 解答選択肢_Cを編集する
        fill_in 'question_answer_c', with: "編集"
        # 解答選択肢_Dを編集する
        fill_in 'question_answer_d', with: "編集"
        # 正解選択肢を指定する
        choose 'question_correct_answer_b'
        # 解説を編集する
        fill_in 'question_description', with: "編集"
        # 編集してもQuestionモデルのカウントは変わらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { Question.count }.by(0)
        # 習得済Tankページに遷移することを確認する
        expect(current_path).to eq learned_tank_questions_path(@tank.id) 
        # 習得済Tankページに先ほど編集したQuestionのquestionが存在することを確認する
        expect(page).to have_content("編集")
        # 習得済Tankページに先ほど編集した解答選択肢_Aが存在することを確認する
        expect(page).to have_content("編集")
        # 習得済Tankページに先ほど編集した解答選択肢_Bが存在することを確認する
        expect(page).to have_content("編集")
        # 習得済Tankページに先ほど編集した解答選択肢_Cが存在することを確認する
        expect(page).to have_content("編集")
        # 習得済Tankページに先ほど編集した解答選択肢_Dが存在することを確認する
        expect(page).to have_content("編集")
      end
    end
  end
  context '【異常系】Question編集_失敗' do
    it 'ユーザがログインしていない場合' do
      # 編集ページへ遷移する
      visit edit_tank_question_path(@tank.id,@question.id)
      # 編集ページへ遷移せず、トップページに戻ったことを確認する
      expect(current_path).to eq root_path
    end
  end
end


RSpec.describe 'Question削除', type: :system, js: true do
  before do
    @question = FactoryBot.create(:question)
    @question.correct_rate = @question.correct_count * 100 / (@question.correct_count + @question.uncorrect_count)
    @question.save
    @tank = @question.tank  
    @tank.tank_type = "問題"
    @tank.tank_name = "test"
    @tank.user_id = @question.user.id
    @tank.save
  end
  context '【正常系】Question削除_成功' do
    it 'ログインしたユーザーでQuestionを削除する場合' do
      # Questionを作成したユーザーでログインする
      sign_in(@question.user)
      # QuestionTank一覧ページへ遷移するアイコンをクリックする
      find("img[src$='tank_img_2.jpg']").click
      # QuestionTankページへ遷移するアイコンをクリックする
      find("img[src$='tank_img_2.jpg']").click
    if @question.correct_rate < 70
       # 未習得Tankページへ遷移するアイコンをクリックする
       find("img[src$='/images/down.jpg']").click
       # Question削除ページへのリンクがあることを確認する
       expect(page).to have_content('削除') 
       # 削除ページへ遷移する
       visit delete_confirm_tank_question_path(@tank.id,@question.id)
       # Questionを削除するとレコードの数が1減ることを確認する
       expect{
         find_link('削除', href: tank_question_path(@tank.id,@question.id)).click
       }.to change { Question.count }.by(-1)
       # 未習得Tankページに遷移することを確認する
       expect(current_path).to eq unlearned_tank_questions_path(@tank.id) 
       # 未習得済Tankページに先ほど作成したQuestionのquestionが存在しないことを確認する
       expect(page).to have_no_content("#{@question}")
       # 未習得Tankページに先ほど作成した解答選択肢_Aが存在しないことを確認する
       expect(page).to have_no_content("#{@question.answer_a}")
       # 未習得Tankページに先ほど作成した解答選択肢_Bが存在しないことを確認する
       expect(page).to have_no_content("#{@question.answer_b}")
       # 未習得Tankページに先ほど作成した解答選択肢_Cが存在しないことを確認する
       expect(page).to have_no_content("#{@question.answer_c}")
       # 未習得Tankページに先ほど作成した解答選択肢_Dが存在しないことを確認する
       expect(page).to have_no_content("#{@question.answer_d}")
    else
       # 習得済Tankページへ遷移するアイコンをクリックする
       find("img[src$='/images/up.jpg']").click
       # Word削除ページへのリンクがあることを確認する
       expect(page).to have_content('削除') 
       # 削除ページへ遷移する
       visit delete_confirm_tank_word_path(@tank.id,@question.id)
       # Wordを削除するとレコードの数が1減ることを確認する
       expect{
         find_link('削除', href: tank_word_path(@tank.id,@question.id)).click
       }.to change { Question.count }.by(-1)
       # 習得済Tankページに遷移することを確認する
       expect(current_path).to eq learned_tank_words_path(@tank.id) 
       # 習得済Tankページに先ほど作成したQuestionのquestionが存在しないことを確認する
       expect(page).to have_no_content("#{@question}")
       # 習得済Tankページに先ほど作成した解答選択肢_Aが存在しないことを確認する
       expect(page).to have_no_content("#{@answer_a}")
       # 習得済Tankページに先ほど作成した解答選択肢_Bが存在しないことを確認する
       expect(page).to have_no_content("#{@answer_b}")
       # 習得済Tankページに先ほど作成した解答選択肢_Cが存在しないことを確認する
       expect(page).to have_no_content("#{@answer_c}")
       # 習得済Tankページに先ほど作成した解答選択肢_Dが存在しないことを確認する
       expect(page).to have_content("#{@answer_d}")
      end
    end
  end
  context '【異常系】Word削除_失敗' do
    it 'ユーザがログインしていない場合' do
      # 削除ページへ遷移する
      visit delete_confirm_tank_word_path(@tank.id,@question.id)
     # 削除ページへ遷移せず、トップページに戻ったことを確認する
      expect(current_path).to eq root_path
    end
  end
end