require 'rails_helper'

RSpec.describe Word, type: :model do
  before do
    @word = FactoryBot.build(:word)
  end

  describe 'Wordの登録' do
    context "【正常系】Wordの登録_成功" do
      it "Word(30文字以内)と意味(120文字以内)がある場合" do
        expect(@word).to be_valid
      end
    end
    context "【異常系】Wordの登録_失敗" do
      it "Wordが空の場合" do
        @word.word = ""
        @word.valid?
        expect(@word.errors.full_messages).to include "Word can't be blank"
      end 
      it "意味が空の場合" do
        @word.meaning = ""
        @word.valid?
        expect(@word.errors.full_messages).to include "Meaning can't be blank"
      end 
      it "重複したwordが存在する場合" do
        @word.save
        another = FactoryBot.build(:word)
        another.word = @word.word
        another.valid?
        expect(another.errors.full_messages).to include "Word has already been taken"  
      end  
      it "Wordが31文字以上の場合" do
        @word.word = Faker::Lorem.characters(number: 31)
        @word.valid?
        expect(@word.errors.full_messages).to include "Word is too long (maximum is 30 characters)"
      end 
      it "意味が121文字以上の場合" do
        @word.meaning =  Faker::Lorem.characters(number: 121)
        @word.valid?
        expect(@word.errors.full_messages).to include "Meaning is too long (maximum is 120 characters)"
      end        
      it "ユーザーとのアソシエーションがない場合" do
        @word.user = nil
        @word.valid?
        expect(@word.errors.full_messages).to include "User must exist"
      end
      it "Tankとのアソシエーションがない場合" do
        @word.tank = nil
        @word.valid?
        expect(@word.errors.full_messages).to include "Tank must exist"
      end
    end
  end
end
