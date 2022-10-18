require 'rails_helper'

RSpec.describe Content, type: :model do
  before do
    @content = FactoryBot.build(:content)
  end

  describe '作品の新規投稿' do
    context '新規投稿できるとき' do
      it '必要な情報があれば投稿できる' do
        expect(@content).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'ユーザーが紐づいていないと投稿できない' do
        @content.user = nil
        @content.valid?
        expect(@content.errors.full_messages).to include("User must exist")
      end
    end
  end
end
