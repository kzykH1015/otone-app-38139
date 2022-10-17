require 'rails_helper'

RSpec.describe Content, type: :model do
  before do
    @content = FactoryBot.build(:content_form)
  end

  describe '作品の新規投稿' do
    context '新規投稿できるとき' do
      it '必要な情報があれば投稿できる' do
        expect(@content).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'titleが空では登録できない' do
        @content.title = ''
        @content.valid?
        expect(@content.errors.full_messages).to include("Title can't be blank")
      end
      
      it 'カテゴリーが未選択では登録できない' do
        @content.category_id = ''
        @content.valid?
        expect(@content.errors.full_messages).to include("Category can't be blank")
      end
      it 'genre_nameが空では登録できない' do
        @content.genre_name = ''
        @content.valid?
        expect(@content.errors.full_messages).to include("Genre name can't be blank")
      end

      it 'creator_nameが空では登録できない' do
        @content.creator_name = ''
        @content.valid?
        expect(@content.errors.full_messages).to include("Creator name can't be blank")
      end

      it 'story_lineが空では登録できない' do
        @content.story_line = ''
        @content.valid?
        expect(@content.errors.full_messages).to include("Story line can't be blank")
      end

      it 'release_dateが空では登録できない' do
        @content.release_date = ''
        @content.valid?
        expect(@content.errors.full_messages).to include("Release date can't be blank")
      end
    end
  end
end
