require 'rails_helper'

RSpec.describe Recommend, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:user)
    @content = FactoryBot.create(:content)
    @recommend = @user.recommend_test(@user, @another_user, @content)
  end

  describe 'recommend新規作成' do
    context 'recommendが投稿できる' do
      it '必要な情報が存在すれば投稿できる' do
        expect(@recommend).to be_valid
      end
    end

    context 'recommendが投稿できない' do
      it 'content_idが空では投稿できない' do
        @recommend.content_id = ''
        @recommend.valid?
        expect(@recommend.errors.full_messages).to include("Content can't be blank", 'Content must exist')
      end
      it 'recommenderが紐づいていなければ投稿できない' do
        @recommend.recommender_id = ''
        @recommend.valid?
        expect(@recommend.errors.full_messages).to include("Recommender can't be blank", 'Recommender must exist')
      end
      it 'recommendedが紐づいていなければ投稿できない' do
        @recommend.recommended_id = ''
        @recommend.valid?
        expect(@recommend.errors.full_messages).to include("Recommended can't be blank", 'Recommended must exist')
      end
    end
  end
end
