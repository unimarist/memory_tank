require 'rails_helper'

RSpec.describe 'Word作成', type: :system, js: true do
  before do
      @tank = FactoryBot.create(:tank)  
      @tank.tank_type = "単語"
      @tank.save
      @word = Faker::Lorem.characters(number: 10)
      @meaning = Faker::Lorem.characters(number: 10)
  end
  context '【正常系】Word登録_成功'do
  it 'ログインしたユーザーでWordを登録する場合' do
    # Tankを作成したユーザーでログインする
    sign_in(@tank.user)
    # WordTank一覧ページへ遷移するアイコンをクリックする
    find("img[src$='tank_img.jpg']").click
    # WordTank一覧ページへ遷移したことを確認する
    expect(current_path).to eq word_tank_index_tank_path(@tank.user_id)
    # WordTankページへ遷移するアイコンをクリックする
    find("img[src$='tank_img.jpg']").click
    # Word登録ページに移動する
    visit new_tank_word_path(@tank.id)
    # Wordを入力する
    fill_in 'word_word', with: @word
    # 意味を入力する
    fill_in 'word_meaning', with: @meaning
    # 送信するとWordモデルのカウントが1上がることを確認する
    expect{
    find('input[name="commit"]').click
    }.to change { Word.count }.by(1)
    # WordTankページへ遷移することを確認する
    expect(current_path).to eq tank_words_path(@tank.id)
    # 未習得Tankページへ遷移するアイコンをクリックする
    find("img[src$='/images/down.jpg']").click
    # 未習得Tankページに先ほど作成したWordのwordが存在することを確認する
    expect(page).to have_content(@word)
    # 未習得Tankページに先ほど作成したWordの意味が存在することを確認する
    expect(page).to have_content(@meaning)
  end
  end
  context '【異常系】Word登録_失敗'do
  it 'ユーザがログインしていない場合' do
     # Word登録ページへ遷移する
     visit new_tank_word_path(@tank.id)
     # 登録ページへ遷移せず、トップページに戻ったことを確認する
     expect(current_path).to eq root_path
  end
  end
end


RSpec.describe 'Word編集', type: :system, js: true do
  before do
    @word = FactoryBot.create(:word)
    @word.correct_rate = @word.correct_count * 100 / (@word.correct_count + @word.uncorrect_count)
    @word.save
    @tank = @word.tank  
    @tank.tank_type = "単語"
    @tank.tank_name = "test"
    @tank.user_id = @word.user.id
    @tank.save
  end
  context '【正常系】Word編集_成功' do
    it 'ログインしたユーザーでWordを編集する場合' do
      # Wordを作成したユーザーでログインする
      sign_in(@word.user)
      # WordTank一覧ページへ遷移するアイコンをクリックする
      find("img[src$='tank_img.jpg']").click
     if @word.correct_rate < 70
       # 未習得Tankページへ遷移するアイコンをクリックする
       find("img[src$='/images/down.jpg']").click
       # # Word編集ページへのリンクがあることを確認する
       expect(page).to have_content('編集') 
       # 編集ページへ遷移する
       visit edit_tank_word_path(@tank.id,@word.id)
       # すでに作成済みの内容がフォームに入っていることを確認する
       expect(
         find('#word_word').value 
       ).to eq @word.word
       expect(
         find('#word_meaning').value 
       ).to eq @word.meaning
       # 投稿内容を編集する
       fill_in 'word_word', with: "#{@word.word}：編集"
       fill_in 'word_meaning', with: "#{@word.meaning}：編集"
       # 編集してもWordモデルのカウントは変わらないことを確認する
       expect{
         find('input[name="commit"]').click
       }.to change { Word.count }.by(0)
       # 未習得Tankページに遷移することを確認する
       expect(current_path).to eq unlearned_tank_words_path(@tank.id) 
       # 未習得Tankページに先ほど編集したWordのwordが存在することを確認する
       expect(page).to have_content("#{@word.word}：編集")
       # 未習得Tankページに先ほど編集したWordの意味が存在することを確認する
       expect(page).to have_content("#{@word.meaning}：編集")
     else
        # 習得済Tankページへ遷移するアイコンをクリックする
        find("img[src$='/images/up.jpg']").click
        #  Word編集ページへのリンクがあることを確認する
        expect(page).to have_content('編集') 
        # 編集ページへ遷移する
        visit edit_tank_word_path(@tank.id,@word.id)
        # すでに作成済みの内容がフォームに入っていることを確認する
        expect(
          find('#word_word').value 
        ).to eq @word.word
        expect(
          find('#word_meaning').value 
        ).to eq @word.meaning
        # 投稿内容を編集する
        fill_in 'word_word', with: "#{@word.word}：編集"
        fill_in 'word_meaning', with: "#{@word.meaning}：編集"
        # 編集してもWordモデルのカウントは変わらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { Word.count }.by(0)
        # 習得済Tankページに遷移することを確認する
        expect(current_path).to eq learned_tank_words_path(@tank.id) 
        # 習得済Tankページに先ほど編集したWordのwordが存在することを確認する
        expect(page).to have_content("#{@word.word}：編集")
        # 習得済Tankページに先ほど編集したWordの意味が存在することを確認する
        expect(page).to have_content("#{@word.meaning}：編集")
      end
    end
  end
  context '【異常系】Word編集_失敗' do
    it 'ユーザがログインしていない場合' do
      # 編集ページへ遷移する
      visit edit_tank_word_path(@tank.id,@word.id)
      # 編集ページへ遷移せず、トップページに戻ったことを確認する
      expect(current_path).to eq root_path
    end
  end
end


RSpec.describe 'Word削除', type: :system, js: true do
  before do
    @word = FactoryBot.create(:word)
    @word.correct_rate = @word.correct_count * 100 / (@word.correct_count + @word.uncorrect_count)
    @word.save
    @tank = @word.tank  
    @tank.tank_type = "単語"
    @tank.tank_name = "test"
    @tank.user_id = @word.user.id
    @tank.save
  end
  context '【正常系】Word削除_成功' do
    it 'ログインしたユーザーでWordを削除する場合' do
      # Wordを作成したユーザーでログインする
      sign_in(@word.user)
      # WordTank一覧ページへ遷移するアイコンをクリックする
      find("img[src$='tank_img.jpg']").click
      # WordTankページへ遷移するアイコンをクリックする
      find("img[src$='tank_img.jpg']").click
    if @word.correct_rate < 70
       # 未習得Tankページへ遷移するアイコンをクリックする
       find("img[src$='/images/down.jpg']").click
       # Word削除ページへのリンクがあることを確認する
       expect(page).to have_content('削除') 
       # 削除ページへ遷移する
       visit delete_confirm_tank_word_path(@tank.id,@word.id)
       # Wordを削除するとレコードの数が1減ることを確認する
       expect{
         find_link('削除する', href: tank_word_path(@tank.id,@word.id)).click
       }.to change { Word.count }.by(-1)
       # 未習得Tankページに遷移することを確認する
       expect(current_path).to eq unlearned_tank_words_path(@tank.id) 
       # 未習得Tankページに先ほど削除したWordのwordが存在することを確認する
       expect(page).to have_no_content("#{@word.word}")
       # 未習得Tankページに先ほど削除したWordの意味が存在することを確認する
       expect(page).to have_no_content("#{@word.meaning}")
    else
       # 習得済Tankページへ遷移するアイコンをクリックする
       find("img[src$='/images/up.jpg']").click
       # Word削除ページへのリンクがあることを確認する
       expect(page).to have_content('削除') 
       # 削除ページへ遷移する
       visit delete_confirm_tank_word_path(@tank.id,@word.id)
       # Wordを削除するとレコードの数が1減ることを確認する
       expect{
         find_link('削除する', href: tank_word_path(@tank.id,@word.id)).click
       }.to change { Word.count }.by(-1)
       # 習得済Tankページに遷移することを確認する
       expect(current_path).to eq learned_tank_words_path(@tank.id) 
       # 習得済Tankページに先ほど削除したWordのwordが存在することを確認する
       expect(page).to have_no_content("#{@word.word}")
       # 習得済Tankページに先ほど削除したWordの意味が存在することを確認する
       expect(page).to have_no_content("#{@word.meaning}")
      end
    end
  end
  context '【異常系】Word削除_失敗' do
    it 'ユーザがログインしていない場合' do
      # 削除ページへ遷移する
      visit delete_confirm_tank_word_path(@tank.id,@word.id)
     # 削除ページへ遷移せず、トップページに戻ったことを確認する
      expect(current_path).to eq root_path
    end
  end
end