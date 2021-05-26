require 'rails_helper'

RSpec.describe 'アカウント登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context '【正常系】アカウント登録_成功' do 
    it '正しいアカウント情報を入力した場合' do
      # トップページに移動する
      visit root_path
      # トップページにアカウント登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # アカウント登録ページへ移動する
      visit new_user_registration_path
      # アカウント情報を入力する
      fill_in 'user_username', with: @user.username
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # 「登録する」ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq root_path
      # ログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # アカウント登録ページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context '【異常系】アカウント登録_失敗' do
    it '誤ったアカウント情報を入力した場合' do
      # トップページに移動する
      visit root_path
      # トップページにアカウント登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # アカウント登録ページへ移動する
      visit new_user_registration_path
      # アカウント情報を入力する
      fill_in 'user_username', with: ""
      fill_in 'user_password', with: ""
      fill_in 'user_password_confirmation', with: ""
      # 「登録する」ボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # アカウント登録ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end
end


RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context '【正常系】ログイン_成功' do
    it 'DBに保存されたログイン情報と入力したログイン情報が一致する場合' do
    # トップページに移動する
    visit root_path
    # トップページにログインページへ遷移するボタンがあることを確認する
    expect(page).to have_content('ログイン')
    # ログインページへ遷移する
    visit new_user_session_path
    # 正しいログイン情報を入力する
    fill_in 'user_username', with: @user.username
    fill_in 'user_password', with: @user.password
    # ログインボタンを押す
    find('input[name="commit"]').click
    # トップページへ遷移することを確認する
    expect(current_path).to eq root_path
    # ログアウトボタンが表示されることを確認する
    expect(page).to have_content('ログアウト')
    # アカウント登録ページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
    expect(page).to have_no_content('新規登録')
    expect(page).to have_no_content('ログイン')
    end
  end
  context '【異常系】ログイン_失敗' do
    it 'DBに保存されたログイン情報と入力したログイン情報が一致しない場合' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 誤ったログイン情報を入力する
      fill_in 'user_username', with: ""
      fill_in 'user_password', with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end