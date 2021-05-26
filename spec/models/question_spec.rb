require 'rails_helper'

RSpec.describe Question, type: :model do
  before do
    @question = FactoryBot.build(:question)
  end

  describe 'Questionの登録' do
    context "【正常系】Questionの登録_成功" do
      it "入力必須項目が全てあり、500文字以内の場合" do
        expect(@question).to be_valid
      end
    end
    context "【異常系】Questionの登録_失敗" do
      it "Questionが空の場合" do
        @question.question = ""
        @question.valid?
        expect(@question.errors.full_messages).to include "Question can't be blank"
      end 
      it "answer_aが空の場合" do
        @question.answer_a = ""
        @question.valid?
        expect(@question.errors.full_messages).to include "Answer a can't be blank"
      end 
      it "answer_bが空の場合" do
        @question.answer_b = ""
        @question.valid?
        expect(@question.errors.full_messages).to include "Answer b can't be blank"
      end 
      it "answer_cが空の場合" do
        @question.answer_c = ""
        @question.valid?
        expect(@question.errors.full_messages).to include "Answer c can't be blank"
      end 
      it "answer_dが空の場合" do
        @question.answer_d = ""
        @question.valid?
        expect(@question.errors.full_messages).to include "Answer d can't be blank"
      end 
      it "correct_answerが空の場合" do
        @question.correct_answer = ""
        @question.valid?
        expect(@question.errors.full_messages).to include "Correct answer can't be blank"
      end 
      it "descriptionが空の場合" do
        @question.description = ""
        @question.valid?
        expect(@question.errors.full_messages).to include "Description can't be blank"
      end 
      it "重複したquestionが存在する場合" do
        @question.save
        another = FactoryBot.build(:question)
        another.question = @question.question
        another.valid?
        expect(another.errors.full_messages).to include "Question has already been taken"  
      end  
      it "Questionが501文字以上の場合" do
        @question.question = Faker::String.random(length: 501)
        @question.valid?
        expect(@question.errors.full_messages).to include "Question is too long (maximum is 500 characters)"
      end 
      it "answer_aが501文字以上の場合" do
        @question.answer_a = Faker::String.random(length: 501)
        @question.valid?
        expect(@question.errors.full_messages).to include "Answer a is too long (maximum is 500 characters)"
      end 
      it "answer_bが501文字以上の場合" do
        @question.answer_b = Faker::String.random(length: 501)
        @question.valid?
        expect(@question.errors.full_messages).to include "Answer b is too long (maximum is 500 characters)"
      end 
      it "answer_cが501文字以上の場合" do
        @question.answer_c = Faker::String.random(length: 501)
        @question.valid?
        expect(@question.errors.full_messages).to include "Answer c is too long (maximum is 500 characters)"
      end 
      it "answer_dが501文字以上の場合" do
        @question.answer_d = Faker::String.random(length: 501)
        @question.valid?
        expect(@question.errors.full_messages).to include "Answer d is too long (maximum is 500 characters)"
      end 
      it "correct_answerが501文字以上の場合" do
        @question.correct_answer = Faker::String.random(length: 501)
        @question.valid?
        expect(@question.errors.full_messages).to include "Correct answer is too long (maximum is 500 characters)"
      end 
      it "descriptionが501文字以上の場合" do
        @question.description = Faker::String.random(length: 501)
        @question.valid?
        expect(@question.errors.full_messages).to include "Description is too long (maximum is 500 characters)"
      end    
      it "ユーザーとのアソシエーションがない場合" do
        @question.user = nil
        @question.valid?
        expect(@question.errors.full_messages).to include "User must exist"
      end
      it "Tankとのアソシエーションがない場合" do
        @question.tank = nil
        @question.valid?
        expect(@question.errors.full_messages).to include "Tank must exist"
      end
    end
  end
end
