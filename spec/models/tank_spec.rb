require 'rails_helper'

RSpec.describe Tank, type: :model do
  before do
    @tank = FactoryBot.build(:tank)
  end

  describe 'Tankの作成' do
    context "【正常系】Tankの作成_成功" do
      it "Tank名(30文字以内)とTankアイコンがある場合" do
        expect(@tank).to be_valid
      end
      it "Tank名(30文字以内)のみある場合" do
        @tank.tank_icon = ""
        expect(@tank).to be_valid
      end
    end
    context "【異常系】Tankの作成_失敗" do
      it "Tank名が空の場合" do
        @tank.tank_name = ""
        @tank.valid?
        expect(@tank.errors.full_messages).to include "Tank name can't be blank"
      end  
      it "Tank名が31文字以上の場合" do
        @tank.tank_name = Faker::Lorem.characters(number: 31)
        @tank.valid?
        expect(@tank.errors.full_messages).to include "Tank name is too long (maximum is 30 characters)"
      end        
      it "ユーザーとのアソシエーションがない場合" do
        @tank.user = nil
        @tank.valid?
        expect(@tank.errors.full_messages).to include "User must exist"
      end
    end
  end
end