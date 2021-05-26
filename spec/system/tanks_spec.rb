require 'rails_helper'

RSpec.describe 'WordTank作成', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tank_name = Faker::Lorem.characters(number: 10)
  end
  context '【正常系】WordTank作成_成功'do
  it 'ログインしたユーザーでWordTankを作成する場合(Tankアイコンをアップロード)' do
    # ログインする
    sign_in(@user)
    # WordTank一覧ページへ遷移するアイコンをクリックする
    find("img[src$='tank_img.jpg']").click
    # WordTank一覧ページに遷移したことを確認する
    expect(current_path).to eq word_tank_index_tank_path(@user.id) 
    # Tank作成ページへのリンクがあることを確認する
    expect(page).to have_content('Tankを作成する')
    # Tank作成ページに移動する
    visit tank_path("単語")
    # Tank名を入力する
    fill_in 'tank_tank_name', with: @tank_name
    # 保存するTankアイコンを定義する
    image_path = Rails.root.join('public/images/test_image.png')
    # 画像選択フォームにてTankアイコンを添付する
    attach_file('tank[tank_icon]', image_path, make_visible: true)
    # 送信するとTankモデルのカウントが1上がることを確認する
    expect{
    find('input[name="commit"]').click
    }.to change { Tank.count }.by(1)
    # WordTank一覧ページに遷移することを確認する
    expect(current_path).to eq word_tank_index_tank_path(@user.id) 
    # WordTank一覧ページに先ほど作成したTankのTank名が存在することを確認する
    expect(page).to have_content(@tank_name)
    # WordTank一覧に先ほど作成したTankのTankアイコンが存在することを確認する
    expect(page).to have_selector("img[src$='test_image.png']")
  end
  it 'ログインしたユーザーでWordTankを作成する場合(Tankアイコンをアップロードしない)' do
    # ログインする
    sign_in(@user)
    # WordTank一覧ページへ遷移するアイコンをクリックする
    find("img[src$='tank_img.jpg']").click
    # WordTank一覧ページへ遷移したことを確認する
    expect(current_path).to eq word_tank_index_tank_path(@user.id) 
    # Tank作成ページへのリンクがあることを確認する
    expect(page).to have_content('Tankを作成する')
    # Tank作成ページに移動する
    visit tank_path("単語")
    # Tank名を入力する
    fill_in 'tank_tank_name', with: @tank_name
    # 送信するとTankモデルのカウントが1上がることを確認する
    expect{
    find('input[name="commit"]').click
    }.to change { Tank.count }.by(1)
    # WordTank一覧ページに遷移することを確認する
    expect(current_path).to eq word_tank_index_tank_path(@user.id) 
    # WordTank一覧ページに先ほど作成したTankのTank名が存在することを確認する
    expect(page).to have_content(@tank_name)
    # WordTank一覧に先ほど作成したTankのデフォルトのTankアイコンが存在することを確認する
    expect(page).to have_selector("img[src$='tank_img.jpg']")
  end
  end
  context '【異常系】WordTank作成_失敗'do
  it 'ユーザがログインしていない場合' do
    # トップページに遷移する
    visit root_path
    # WordTank一覧ページへ遷移するアイコンをクリックする
    find("img[src$='tank_img.jpg']").click
    # WordTank一覧ページへ遷移せず、トップページに戻ったことを確認する
     expect(current_path).to eq root_path
  end
  end
end


RSpec.describe 'QuestionTank作成', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tank_name = Faker::Lorem.characters(number: 10)
  end
  context '【正常系】QuestionTank作成_成功'do
  it 'ログインしたユーザーでQuestionTankを作成する場合(Tankアイコンをアップロード)' do
    # ログインする
    sign_in(@user)
    # QuestionTank一覧ページへ遷移するアイコンをクリックする
    find("img[src$='tank_img_2.jpg']").click
    # QuestionTank一覧ページに遷移したことを確認する
    expect(current_path).to eq question_tank_index_tank_path(@user.id) 
    # Tank作成ページへのリンクがあることを確認する
    expect(page).to have_content('Tankを作成する')
    # Tank作成ページに移動する
    visit tank_path("問題")
    # Tank名を入力する
    fill_in 'tank_tank_name', with: @tank_name
    # 保存するTankアイコンを定義する
    image_path = Rails.root.join('public/images/test_image.png')
    # 画像選択フォームにてTankアイコンを添付する
    attach_file('tank[tank_icon]', image_path, make_visible: true)
    # 送信するとTankモデルのカウントが1上がることを確認する
    expect{
    find('input[name="commit"]').click
    }.to change { Tank.count }.by(1)
    # QuestionTank一覧ページに遷移することを確認する
    expect(current_path).to eq question_tank_index_tank_path(@user.id) 
    # QuestionTank一覧ページに先ほど作成したTankのTank名が存在することを確認する
    expect(page).to have_content(@tank_name)
    # QuestionTank一覧に先ほど作成したTankのTankアイコンが存在することを確認する
    expect(page).to have_selector("img[src$='test_image.png']")
  end
  it 'ログインしたユーザーでQuestionTankを作成する場合(Tankアイコンをアップロードしない)' do
    # ログインする
    sign_in(@user)
    # QuestionTank一覧ページへ遷移するアイコンをクリックする
    find("img[src$='tank_img_2.jpg']").click
    # QuestionTank一覧ページへ遷移したことを確認する
    expect(current_path).to eq question_tank_index_tank_path(@user.id) 
    # Tank作成ページへのリンクがあることを確認する
    expect(page).to have_content('Tankを作成する')
    # Tank作成ページに移動する
    visit tank_path("問題")
    # Tank名を入力する
    fill_in 'tank_tank_name', with: @tank_name
    # 送信するとTankモデルのカウントが1上がることを確認する
    expect{
    find('input[name="commit"]').click
    }.to change { Tank.count }.by(1)
    # QuestionTank一覧ページに遷移することを確認する
    expect(current_path).to eq question_tank_index_tank_path(@user.id) 
    # QuestionTank一覧ページに先ほど作成したTankのTank名が存在することを確認する
    expect(page).to have_content(@tank_name)
    # QuestionTank一覧に先ほど作成したTankのデフォルトのTankアイコンが存在することを確認する
    expect(page).to have_selector("img[src$='tank_img_2.jpg']")
  end
  end
  context '【異常系】QuestionTank作成_失敗'do
  it 'ユーザがログインしていない場合' do
    # トップページに遷移する
    visit root_path
    # QUestionTank一覧ページへ遷移するアイコンをクリックする
    find("img[src$='tank_img_2.jpg']").click
    # QuestionTank一覧ページへ遷移せず、トップページに戻ったことを確認する
    expect(current_path).to eq root_path
  end
  end
end


RSpec.describe 'WordTank編集', type: :system do
    before do
      @tank = FactoryBot.create(:tank)  
      @tank.tank_type = "単語"
      @tank.save
    end
    context '【正常系】WordTank編集_成功' do
      it 'ログインしたユーザーでWordTankを編集する場合' do
        # Tankを作成したユーザーでログインする
        sign_in(@tank.user)
        # WordTank一覧ページへ遷移するアイコンをクリックする
        find("img[src$='tank_img.jpg']").click
        # WordTank一覧ページへ遷移したことを確認する
        expect(current_path).to eq word_tank_index_tank_path(@tank.user_id)
        # Tank編集ページへのリンクがあることを確認する
        expect(page).to have_content('編集') 
        # 編集ページへ遷移する
        visit edit_tank_path(@tank.id)
        # すでに作成済みの内容がフォームに入っていることを確認する
        expect(
          find('#tank_tank_name').value 
        ).to eq @tank.tank_name
        expect(page).to have_selector("img[src$='tank_img.jpg']") 
        # 投稿内容を編集する
        fill_in 'tank_tank_name', with: "#{@tank.tank_name}：編集"
        image_path = Rails.root.join('public/images/test_image.png')
        attach_file('tank[tank_icon]', image_path, make_visible: true)
        # 編集してもTankモデルのカウントは変わらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { Tank.count }.by(0)
        # WordTank一覧ページに遷移することを確認する
        expect(current_path).to eq word_tank_index_tank_path(@tank.user_id) 
        # WordTank一覧ページに先ほど編集したTankのTank名が存在することを確認する
        expect(page).to have_content("#{@tank.tank_name}：編集")
        # WordTank一覧に先ほど編集したTankのTankアイコンが存在することを確認する
        expect(page).to have_selector("img[src$='test_image.png']")
      end
    end
    context '【異常系】WordTank編集_失敗' do
      it 'ユーザがログインしていない場合' do
        # 編集ページへ遷移する
        visit edit_tank_path(@tank.id)
        # 編集ページへ遷移せず、トップページに戻ったことを確認する
        expect(current_path).to eq root_path
      end
    end
end


RSpec.describe 'QuestionTank編集', type: :system do
  before do
    @tank = FactoryBot.create(:tank)  
    @tank.tank_type = "問題"
    @tank.save
  end
  context '【正常系】QuestionTank編集_成功' do
    it 'ログインしたユーザーでQuestionTankを編集する場合' do
      # Tankを作成したユーザーでログインする
      sign_in(@tank.user)
      # QuestionTank一覧ページへ遷移するアイコンをクリックする
      find("img[src$='tank_img_2.jpg']").click
      # QuestionTank一覧ページへ遷移したことを確認する
      expect(current_path).to eq question_tank_index_tank_path(@tank.user_id)
      # Tank編集ページへのリンクがあることを確認する
      expect(page).to have_content('編集') 
      # 編集ページへ遷移する
      visit edit_tank_path(@tank.id)
      # すでに作成済みの内容がフォームに入っていることを確認する
      expect(
        find('#tank_tank_name').value 
      ).to eq @tank.tank_name
      expect(page).to have_selector("img[src$='tank_img_2.jpg']") 
      # 投稿内容を編集する
      fill_in 'tank_tank_name', with: "#{@tank.tank_name}：編集"
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file('tank[tank_icon]', image_path, make_visible: true)
      # 編集してもTankモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Tank.count }.by(0)
      # QuestionTank一覧ページに遷移することを確認する
      expect(current_path).to eq question_tank_index_tank_path(@tank.user_id) 
      # QuestionTank一覧ページに先ほど編集したTankのTank名が存在することを確認する
      expect(page).to have_content("#{@tank.tank_name}：編集")
      # QuestionTank一覧に先ほど編集したTankのTankアイコンが存在することを確認する
      expect(page).to have_selector("img[src$='test_image.png']")
    end
  end
  context '【異常系】QuestionTank編集_失敗' do
    it 'ユーザがログインしていない場合' do
      # 編集ページへ遷移する
      visit edit_tank_path(@tank.id)
     # 編集ページへ遷移せず、トップページに戻ったことを確認する
      expect(current_path).to eq root_path
    end
  end
end


RSpec.describe 'WordTank削除', type: :system do
  before do
    @tank = FactoryBot.create(:tank)  
    @tank.tank_type = "単語"
    @tank.save
  end
  context '【正常系】WordTank削除_成功' do
    it 'ログインしたユーザーでWordTankを削除する場合' do
      # Tankを作成したユーザーでログインする
      sign_in(@tank.user)
      # WordTank一覧ページへ遷移するアイコンをクリックする
      find("img[src$='tank_img.jpg']").click
      # WordTank一覧ページへ遷移したことを確認する
      expect(current_path).to eq word_tank_index_tank_path(@tank.user_id)
      # Tank削除ページへのリンクがあることを確認する
      expect(page).to have_content('削除') 
      # 削除ページへ遷移する
      visit delete_confirm_tank_path(@tank.id)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        find_link('削除する', href: tank_path(@tank.id)).click
      }.to change { Tank.count }.by(-1)
      # WordTank一覧ページへ遷移したことを確認する
      expect(current_path).to eq word_tank_index_tank_path(@tank.user_id)
      # トップページには削除したTankのTank名が存在しないことを確認する
      expect(page).to have_no_content("#{@tank.tank_name}")
     # トップページには削除したTankのTankアイコンが存在しないことを確認する
      expect(page).to have_no_selector("img[src$='tank_img.png']")
    end
  end
  context '【異常系】WordTank削除_失敗' do
    it 'ユーザがログインしていない場合' do
      # 削除ページへ遷移する
      visit delete_confirm_tank_path(@tank.id)
     # 削除ページへ遷移せず、トップページに戻ったことを確認する
      expect(current_path).to eq root_path
    end
  end
end


RSpec.describe 'QuestionTank削除', type: :system do
  before do
    @tank = FactoryBot.create(:tank)  
    @tank.tank_type = "問題"
    @tank.save
  end
  context '【正常系】QuestionTank削除_成功' do
    it 'ログインしたユーザーでQuestionTankを削除する場合' do
      # Tankを作成したユーザーでログインする
      sign_in(@tank.user)
      # QuestionTank一覧ページへ遷移するアイコンをクリックする
      find("img[src$='tank_img_2.jpg']").click
      # QuestionTank一覧ページへ遷移したことを確認する
      expect(current_path).to eq question_tank_index_tank_path(@tank.user_id)
      # Tank削除ページへのリンクがあることを確認する
      expect(page).to have_content('削除') 
      # 削除ページへ遷移する
      visit delete_confirm_tank_path(@tank.id)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        find_link('削除する', href: tank_path(@tank.id)).click
      }.to change { Tank.count }.by(-1)
      # QuestionTank一覧ページへ遷移したことを確認する
      expect(current_path).to eq question_tank_index_tank_path(@tank.user_id)
      # トップページには削除したTankのTank名が存在しないことを確認する
      expect(page).to have_no_content("#{@tank.tank_name}")
     # トップページには削除したTankのTankアイコンが存在しないことを確認する
      expect(page).to have_no_selector("img[src$='tank_img_2.png']")
    end
  end
  context '【異常系】QuestionTank削除_失敗' do
    it 'ユーザがログインしていない場合' do
      # 削除ページへ遷移する
      visit delete_confirm_tank_path(@tank.id)
     # 削除ページへ遷移せず、トップページに戻ったことを確認する
      expect(current_path).to eq root_path
    end
  end
end