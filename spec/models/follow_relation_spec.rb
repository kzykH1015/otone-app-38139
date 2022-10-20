require 'rails_helper'

RSpec.describe FollowRelation, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:user)
    @follow = @user.follow(@another_user.id)
  end

  describe 'フォロー機能テスト' do
    context 'フォローできる時' do
      it 'フォローするuserとフォローされるuserが存在すれば、フォローできる' do
        expect(@follow).to be_valid
      end
    end

    context 'フォローできる時' do
      it 'フォローするuserが存在しない時、フォローできない' do
        @follow.follower_id = ''
        @follow.valid?
        expect(@follow.errors.full_messages).to include('Follower must exist', "Follower can't be blank")
      end
      it 'フォローされるuserが存在しない時、フォローできない' do
        @follow.followed_id = ''
        @follow.valid?
        expect(@follow.errors.full_messages).to include('Followed must exist', "Followed can't be blank")
      end
      it '既に同じ組み合わせが存在する時、保存できない' do
        @follow.save
        another_follow = @user.follow(@another_user.id)
        another_follow.follower_id = @follow.follower_id
        another_follow.followed_id = @follow.followed_id
        another_follow.valid?
        expect(another_follow.errors.full_messages).to include('Follower has already been taken')
      end
    end
  end
end
