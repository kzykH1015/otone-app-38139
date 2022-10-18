require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント新規投稿' do
    context 'コメントが新規投稿できるとき' do
      it 'コメントテキストとユーザー、コンテンツが紐づいていれば投稿できる' do
        expect(@comment).to be_valid
      end
    end

    context '新規投稿できないとき' do
      it 'コメントテキストがないと投稿できない' do
        @comment.comment_text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Comment text can't be blank")
      end

      it 'ユーザーが紐づいていないと投稿できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('User must exist')
      end

      it 'コンテンツが紐づいていないと投稿できない' do
        @comment.content = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Content must exist')
      end
    end
  end
end
