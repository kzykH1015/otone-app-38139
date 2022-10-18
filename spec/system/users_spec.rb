require 'rails_helper'
def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      fill_in 'user_self_introduction', with: @user.self_introduction
      # Nextボタンを押すとネタバレ選択画面に遷移する
      find('input[name="commit"]').click
      expect(page).to have_content("ネタバレ防止設定")
      # 各spoilerを選択する
      select '表示しない', from: 'spoiler[genre_spoiler_id]'
      select '表示しない', from: 'spoiler[creator_spoiler_id]'
      select '表示しない', from: 'spoiler[story_line_spoiler_id]'
      select '表示しない', from: 'spoiler[release_date_spoiler_id]'
      select '表示しない', from: 'spoiler[comment_spoiler_id]'
      # Sign upボタンを押すとUserモデルのカウントが１上がる
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # 新規登録完了画面へ遷移したことを確認する
      expect(current_path).to eq(spoilers_path)
      click_link "トップへ戻る"
      # トップページに遷移したことを確認
      expect(current_path).to eq(root_path)
      # ヘッダーにuserのnicknameとログアウトボタンが表示されることを確認する
      expect(page).to have_content(@user.nickname)
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに登録ページへ戻る' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力しない
      fill_in 'user_nickname', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''
      fill_in 'user_self_introduction', with: ''
      # Nextボタンを押しても画面が遷移しないことを確認する
      expect(current_path).to eq(new_user_registration_path)
      # 再度ユーザー情報を入力して画面を移動する
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      fill_in 'user_self_introduction', with: @user.self_introduction
      # Nextボタンを押すとネタバレ選択画面に遷移する
      find('input[name="commit"]').click
      # 各spoilerを選択しない
      select '---', from: 'spoiler[genre_spoiler_id]'
      select '表示しない', from: 'spoiler[creator_spoiler_id]'
      select '表示しない', from: 'spoiler[story_line_spoiler_id]'
      select '表示しない', from: 'spoiler[release_date_spoiler_id]'
      select '表示しない', from: 'spoiler[comment_spoiler_id]'
      # Sign upボタンを押すとUserモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # ネタバレ選択画面に戻されることを確認する
      expect(page).to have_content("ネタバレ防止設定")
    end
  end
end
