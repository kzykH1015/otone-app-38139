require 'rails_helper'

RSpec.describe History, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @content = FactoryBot.create(:content)
    @message = 'aaaaa'
    @history = History.create_log(@content.id, @user.id, @message)
  end

  describe '編集履歴のテスト' do
    context '編集履歴が残る時' do
      it '条件が揃えば編集履歴が残る' do
        expect(@history).to be_valid
      end
    end
    context '編集履歴が残らない時' do
      it 'userが紐づいていない時、user_idが空になり、履歴が残らない' do
        @history.user = nil
        @history.valid?
        expect(@history.errors.full_messages).to include("User can't be blank")
      end
      it 'contentが紐づいていない時、content_idが空になり、履歴が残らない' do
        @history.content = nil
        @history.valid?
        expect(@history.errors.full_messages).to include("Content can't be blank")
      end
      it 'messageが空の時、履歴が残らない' do
        @history.message = ''
        @history.valid?
        expect(@history.errors.full_messages).to include("Message can't be blank")
      end
    end
  end
end
