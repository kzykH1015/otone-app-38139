require 'rails_helper'

RSpec.describe Spoiler, type: :model do
  before do
    @spoiler = FactoryBot.build(:spoiler)
  end

  describe 'ネタバレの選択' do
    context 'ネタバレの選択の登録ができる時' do
      it '全ての項目を選択したら登録できる' do
        expect(@spoiler).to be_valid
      end
    end

    context 'ネタバレの登録ができない時' do
      it 'genre_spoilerを選択しないと登録できない' do
        @spoiler.genre_spoiler_id = ''
        @spoiler.valid?
        expect(@spoiler.errors.full_messages).to include("Genre spoiler can't be blank")
      end
      it 'creator_spoilerを選択しないと登録できない' do
        @spoiler.creator_spoiler_id = ''
        @spoiler.valid?
        expect(@spoiler.errors.full_messages).to include("Creator spoiler can't be blank")
      end
      it 'story_line_spoilerを選択しないと登録できない' do
        @spoiler.story_line_spoiler_id = ''
        @spoiler.valid?
        expect(@spoiler.errors.full_messages).to include("Story line spoiler can't be blank")
      end
      it 'release_date_spoilerを選択しないと登録できない' do
        @spoiler.release_date_spoiler_id = ''
        @spoiler.valid?
        expect(@spoiler.errors.full_messages).to include("Release date spoiler can't be blank")
      end
      it 'comment_spoilerを選択しないと登録できない' do
        @spoiler.comment_spoiler_id = ''
        @spoiler.valid?
        expect(@spoiler.errors.full_messages).to include("Comment spoiler can't be blank")
      end
    end
  end
end
