require 'rails_helper'
def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end


RSpec.describe "ContentForms", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @content_form = FactoryBot.build(:content_form)
    @date = "002000/10/15"
  end
  context '作品の新規投稿ができるとき' do 
    it '正しい情報を入力すれば作品の新規投稿ができてトップページに移動する' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # トップページに作品投稿ページへ遷移するボタンがあることを確認する
      expect(page).to have_content("作品投稿")
      # 作品投稿ページへ移動する
      visit new_content_path
      # 作品の情報を入力する
      fill_in 'content_form_title', with: @content_form.title
      select 'アニメ', from: 'content_form[category_id]'
      fill_in 'genre-name', with: @content_form.genre_name
      fill_in 'creator-name', with: @content_form.creator_name
      fill_in 'content_form_story_line', with: @content_form.story_line
      fill_in 'content_form_release_date', with: @date
      # 投稿ボタンを押すとcontentモデルのカウントが１上がり、トップページに遷移する
      expect{
        find('input[name="commit"]').click
      }.to change { Content.count }.by(1)
      expect(current_path).to eq(root_path)
      # トップページに投稿した作品が表示されていることを確認
      expect(page).to have_content(@content_form.title)
    end
  end
  context '作品の新規投稿ができないとき' do
    it '誤った情報では作品の新規投稿ができずに投稿ページへ戻る' do
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # トップページに作品投稿ページへ遷移するボタンがあることを確認する
      expect(page).to have_content("作品投稿")
      # 作品投稿ページへ移動する
      visit new_content_path
      # 作品の情報を入力する
      fill_in 'content_form_title', with: ''
      select 'アニメ', from: 'content_form[category_id]'
      fill_in 'genre-name', with: @content_form.genre_name
      fill_in 'creator-name', with: @content_form.creator_name
      fill_in 'content_form_story_line', with: ''
      fill_in 'content_form_release_date', with: @date
      # 投稿ボタンを押すとcontentモデルのカウントが変化せず、投稿ページに戻る
      expect{
        find('input[name="commit"]').click
      }.to change { Content.count }.by(0)
      expect(page).to have_content("作品新規投稿")
    end
  end
end
