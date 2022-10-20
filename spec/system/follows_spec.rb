require 'rails_helper'
def basic_pass(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'フォローする', type: :system do
  before do
    @user = FactoryBot.build(:user)
    @another_user = FactoryBot.build(:user)
    @content_form = FactoryBot.build(:content_form)
    @date = '002000/10/15'
  end
  context 'ユーザーをフォローできる時' do
    it 'まだフォローしていないユーザーならフォローできる' do
      # basic認証
      basic_pass root_path
      # ユーザー新規登録
      new_user(@user)
      # 作品の新規投稿
      new_content(@content_form, @date)
      # ログアウトし、二人目のユーザーを登録
      click_link 'ログアウト'
      new_user(@another_user)
      # 作品の詳細ページへ移動し、それを確認
      click_link "#{@content_form.title}"
      expect(page).to have_content("【#{@content_form.title}】詳細ページ")
      # 投稿したユーザーの詳細ページに移動する
      click_link "#{@user.nickname}"
      # フォローボタンがあることを確認する
      expect(page).to have_selector '.no-follow-star'
      # フォローボタンを押すとモデルのカウントが1上がり、ボタンの見た目が変わる
      expect do
        click_link '☆'
      end.to change { FollowRelation.count }.by(1)
      expect(page).to have_selector '.follow-star'
      # 自身の詳細ページにお気に入りしたユーザーが表示されていることを確認する
      visit root_path
      click_link "#{@another_user.nickname}"
      expect(page).to have_content("#{@user.nickname}")
    end
  end
end

RSpec.describe 'フォローを外す', type: :system do
  before do
    @user = FactoryBot.build(:user)
    @another_user = FactoryBot.build(:user)
    @content_form = FactoryBot.build(:content_form)
    @date = '002000/10/15'
  end
  context 'ユーザーのフォローを解除できる' do
    it '既にフォロー済みのユーザーなら解除できる' do
      # basic認証
      basic_pass root_path
      # ユーザー新規登録
      new_user(@user)
      # 作品の新規投稿
      new_content(@content_form, @date)
      # ログアウトし、二人目のユーザーを登録
      click_link 'ログアウト'
      new_user(@another_user)
      # 作品の詳細ページへ移動し、それを確認
      click_link "#{@content_form.title}"
      expect(page).to have_content("【#{@content_form.title}】詳細ページ")
      # 投稿したユーザーの詳細ページに移動する
      click_link "#{@user.nickname}"
      # フォローボタンがあることを確認する
      expect(page).to have_selector '.no-follow-star'
      # フォローボタンを押すとモデルのカウントが1上がり、ボタンの見た目が変わる
      expect do
        click_link '☆'
      end.to change { FollowRelation.count }.by(1)
      expect(page).to have_selector '.follow-star'
      # 再度ボタンを押すとフォローを解除できる
      expect do
        click_link '★'
      end.to change { FollowRelation.count }.by(-1)
      expect(page).to have_selector '.no-follow-star'
      # 自身の詳細ページに解除したユーザーが表示されていないことを確認する
      visit root_path
      click_link "#{@another_user.nickname}"
      expect(page).to have_no_content("#{@user.nickname}")
    end
  end
end
