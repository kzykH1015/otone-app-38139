require 'rails_helper'
def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end


RSpec.describe "作品新規作成", type: :system do
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
      sign_in(@user)
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
      sign_in(@user)
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

RSpec.describe "作品情報編集", type: :system do
  before do
    @user = FactoryBot.build(:user)
    @content_form = FactoryBot.build(:content_form)
    @date = "002000/10/15"
  end
  context '作品の情報を編集できるとき' do 
    it '正しく情報を入力すれば、作品の情報が更新され作品詳細ページに移動する' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # ユーザーを作成する
      new_user(@user)
      # 作品を保存する
      new_content(@user, @content_form, @date)
      # 作品詳細詳細ページに移動する
      click_link "#{@content_form.title}"
      expect(page).to have_content("【#{@content_form.title}】詳細ページ")
      # 作品の編集ページに移動
      click_link "作品の情報を編集する"
      # 現在の作品の情報が初期値になっているか確認
      expect(
        find('#content_form_title').value
      ).to eq(@content_form.title)
      expect(
        find('#content-category').value
      ).to eq("#{@content_form.category_id}")
      expect(
        find('#genre-name').value
      ).to eq(@content_form.genre_name)
      expect(
        find('#creator-name').value
      ).to eq(@content_form.creator_name)
      expect(
        find('#content_form_story_line').value
      ).to eq(@content_form.story_line)
      expect(
        find('#content_form_release_date').value
      ).to eq("2000-10-15")
      # 内容を変更
      fill_in 'content_form_title', with: "newtitle"
      # 変更を保存した際にモデルのカウントが変わらないことを確認する
      expect{
      find('input[name="commit"]').click
      }.to change { Content.count }.by(0)
      # 商品詳細ページに戻り内容が更新されたことを確認する
      expect(page).to have_content("【newtitle】詳細ページ")
    end
  end
  context '作品の情報を編集できないとき' do
    it '情報に抜けがあると、作品の情報が更新されず編集ページに戻る' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # ユーザーを作成する
      new_user(@user)
      # 作品を保存する
      new_content(@user, @content_form, @date)
      # 作品詳細詳細ページに移動する
      click_link "#{@content_form.title}"
      expect(page).to have_content("【#{@content_form.title}】詳細ページ")
      # 作品の編集ページに移動
      click_link "作品の情報を編集する"
      # 現在の作品の情報が初期値になっているか確認
      expect(
        find('#content_form_title').value
      ).to eq(@content_form.title)
      expect(
        find('#content-category').value
      ).to eq("#{@content_form.category_id}")
      expect(
        find('#genre-name').value
      ).to eq(@content_form.genre_name)
      expect(
        find('#creator-name').value
      ).to eq(@content_form.creator_name)
      expect(
        find('#content_form_story_line').value
      ).to eq(@content_form.story_line)
      expect(
        find('#content_form_release_date').value
      ).to eq("2000-10-15")
      # 内容を空に変更
      fill_in 'content_form_title', with: ""
      # 修正ボタンを押しても、更新されずに編集ページに戻ることを確認する
      find('input[name="commit"]').click
      expect(page).to have_content("作品情報編集")
    end
  end
end
