require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @like = FactoryBot.build(:like)
  end

  describe 'お気に入り機能テスト' do
    context 'お気に入りにできる時' do
      it 'userとcontentが存在すればお気に入りにできる' do
        expect(@like).to be_valid
      end
    end

    context 'お気に入りにできない時' do
      it 'userが存在しないときお気に入りにできない' do
        @like.user = nil
        @like.valid?
        expect(@like.errors.full_messages).to include('User must exist')
      end
      it 'contentが存在しないときお気に入りにできない' do
        @like.content = nil
        @like.valid?
        expect(@like.errors.full_messages).to include('Content must exist')
      end
    end
  end
end
