require 'rails_helper'
def basic_pass(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "お気に入り登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
    @another_user = FactoryBot.build(:user)
    @content_form = FactoryBot.build(:content_form)
    @date = "002000/10/15"
  end
  context "作品をお気に入りできる時" do
    it "まだお気に入りにしていない作品をお気に入りにできる" do
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
      # お気に入りボタンをクリックすると見た目が変わり、モデルのカウントが1上がる
      expect(page).to have_selector ".like-icon"
      expect do
        click_link "❤︎"
      end.to change { Like.count }.by(1)
      expect(page).to have_selector ".liked-icon"
      # 自身の詳細ページにお気に入りした作品が表示されていることを確認する
      visit root_path
      click_link "#{@another_user.nickname}"
      expect(page).to have_content("#{@content_form.title}")
    end
  end
end

RSpec.describe "お気に入り解除", type: :system do
  before do
    @user = FactoryBot.build(:user)
    @another_user = FactoryBot.build(:user)
    @content_form = FactoryBot.build(:content_form)
    @date = "002000/10/15"
  end
  context "作品のお気に入りを解除できる時" do
    it "既にお気に入りにした作品なら、お気に入りを解除できる" do
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
      # お気に入りボタンをクリックすると見た目が変わり、モデルのカウントが1上がる
      expect(page).to have_selector ".like-icon"
      expect do
        click_link "❤︎"
      end.to change { Like.count }.by(1)
      expect(page).to have_selector ".liked-icon"
      # 再度お気に入りボタンをクリックすると色が変わり、モデルのカウントが1下がる
      expect(page).to have_selector ".liked-icon"
      expect do
        click_link "❤︎"
      end.to change { Like.count }.by(-1)
      expect(page).to have_selector ".like-icon"
      # 自身の詳細ページにお気に入りした作品に何も表示されていないことを確認する
      visit root_path
      click_link "#{@another_user.nickname}"
      expect(page).to have_no_content("#{@content_form.title}")
    end
  end
end
