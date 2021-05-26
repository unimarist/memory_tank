require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.build(:user)
  end

  describe "アカウント登録" do  

   context '【正常系】アカウント登録_成功' do
    it "username、password、password_confirmationが存在する場合" do
      expect(@user).to be_valid
    end

    it "usernameが15文字以下の場合" do
      @user.username = Faker::Name.initials(number: 15)
      expect(@user).to be_valid
    end

    it "passwordとpassword_confirmationが6文字以上の場合" do
      @user.password = Faker::Internet.password(min_length: 6)
      @user.password_confirmation = @user.password
      expect(@user).to be_valid
    end
   end
   
   context '【異常系】アカウント登録_失敗' do
    it "usernameが空の場合" do
      @user.username =""
      @user.valid?
      expect(@user.errors.full_messages).to include "Username can't be blank"
    end
    it "passwordが空の場合" do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end
    it "passwordが存在し、password_confirmationが空の場合" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end
    it "重複したusernameが存在する場合" do
      @user.save
      another = FactoryBot.build(:user)
      another.username = @user.username
      another.valid?
      expect(another.errors.full_messages).to include "Username has already been taken"  
    end
    it "usernameが16文字以上の場合" do
      @user.username = Faker::Name.initials(number: 16)
      expect(@user).to be_valid
    end
    it "passwordが5文字以下の場合" do
      @user.password =  "test"
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
    end
   end
  end
end