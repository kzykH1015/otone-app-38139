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
      expect(page).to have_content("ログアウト")
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

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content("ログイン")
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # ヘッダーにuserのnicknameとログアウトボタンが表示されることを確認する
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content("ログアウト")
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content("ログイン")
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe 'ログアウト', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログアウトができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      basic_pass root_path
      visit root_path
      # ログインする
      sign_in(@user)
      # ヘッダーにuserのnicknameとログアウトボタンが表示されることを確認する
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content("ログアウト")
      # ログアウトボタンをクリックする
      click_link "ログアウト"
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていることを確認する
      expect(page).to have_content('新規登録')
      expect(page).to have_content('ログイン')
    end
  end
  context 'ログアウトができないとき' do
    it 'ログインしていないとログアウトできない' do
      # トップページに移動する
      visit root_path
      # トップページにログアウトボタンがないことを確認する
      expect(page).to have_no_content("ログアウト")
    end
  end
end

RSpec.describe 'ユーザー編集' , type: :system do
  before do
    @user = FactoryBot.build(:user)
    @spoiler = FactoryBot.build(:spoiler)
  end
  context 'ユーザー情報を編集できる時' do
    it '新規登録したユーザーは自分の情報を編集できる' do
      # トップページへ
      basic_pass root_path
      visit root_path
      # ユーザー新規登録
      new_user(@user)
      # ユーザーの詳細ページへ移動する
      click_link "#{@user.nickname}"
      # 編集ページへ移動する
      click_link "情報を編集する"
      # 現在の情報が初期値として入力されていることを確認する
      expect(
        find('#user_nickname').value
      ).to eq(@user.nickname)
      expect(
        find('#user_self_introduction').value
      ).to eq(@user.self_introduction)
      expect(
        find('#user_email').value
      ).to eq(@user.email)
      # 変更する項目を入力する
      fill_in 'user_nickname', with: "newnewnew"
      # Nextボタンを押すとネタバレ選択画面に遷移する
      find('input[name="commit"]').click
      expect(page).to have_content "ネタバレ防止設定の変更"
      # 現在のネタバレ設定が表示されているか確認する
      expect(
        find('#gsi').value
      ).to eq("#{@spoiler.genre_spoiler_id}")
      expect(
        find('#csi').value
      ).to eq("#{@spoiler.creator_spoiler_id}")
      expect(
        find('#slsi').value
      ).to eq("#{@spoiler.story_line_spoiler_id}")
      expect(
        find('#rdsi').value
      ).to eq("#{@spoiler.release_date_spoiler_id}")
      expect(
        find('#cosi').value
      ).to eq("#{@spoiler.comment_spoiler_id}")
      # ネタバレの設定を変更する
      select '表示する', from: 'spoiler[creator_spoiler_id]'
      # 変更を保存した際にモデルのカウントが変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # ユーザー詳細ページに戻ったことを確認する
      expect(page).to have_content("ユーザー情報")
      # 編集した内容が反映されていることを確認する
      expect(page).to have_content("newnewnew")
    end
  end
  
  context 'ユーザー情報を編集できない時' do
    it '編集の際に必要な情報を空欄にすると更新できない' do
      # トップページへ
      basic_pass root_path
      visit root_path
      # ユーザー新規登録
      new_user(@user)
      # ユーザーの詳細ページへ移動する
      click_link "#{@user.nickname}"
      # 編集ページへ移動する
      click_link "情報を編集する"
      # 現在の情報が初期値として入力されていることを確認する
      expect(
        find('#user_nickname').value
      ).to eq(@user.nickname)
      expect(
        find('#user_self_introduction').value
      ).to eq(@user.self_introduction)
      expect(
        find('#user_email').value
      ).to eq(@user.email)
      # 変更する項目を入力する
      fill_in 'user_nickname', with: ""
      # Nextボタンを押すとユーザー情報編集画面に戻される
      find('input[name="commit"]').click
      expect(page).to have_content "ユーザー情報編集"
      # 情報を入力するとネタバレ設定画面に遷移できる
      fill_in 'user_nickname', with: "newnewnew"
      find('input[name="commit"]').click
      expect(page).to have_content "ネタバレ防止設定の変更"
      # 現在のネタバレ設定が表示されているか確認する
      expect(
        find('#gsi').value
      ).to eq("#{@spoiler.genre_spoiler_id}")
      expect(
        find('#csi').value
      ).to eq("#{@spoiler.creator_spoiler_id}")
      expect(
        find('#slsi').value
      ).to eq("#{@spoiler.story_line_spoiler_id}")
      expect(
        find('#rdsi').value
      ).to eq("#{@spoiler.release_date_spoiler_id}")
      expect(
        find('#cosi').value
      ).to eq("#{@spoiler.comment_spoiler_id}")
      # ネタバレの設定を選択しない
      select '---', from: 'spoiler[genre_spoiler_id]'
      # Updateボタンを押してもネタバレ設定画面に戻される
      find('input[name="commit"]').click
      expect(page).to have_content "ネタバレ防止設定の変更"
    end
  end
end