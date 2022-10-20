require 'rails_helper'
def basic_pass(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'オススメ機能', type: :system do
  before do
    @user = FactoryBot.build(:user)
    @another_user = FactoryBot.build(:user)
    @content_form = FactoryBot.build(:content_form)
    @another_content = FactoryBot.build(:content_form)
    @date = '002000/10/15'
  end
  context '作品をオススメできる時' do
    it '作品が投稿されており、自身以外のユーザーが存在すればオススメできる', js: true do
      # basic認証
      basic_pass root_path
      # ユーザー新規登録
      new_user(@user)
      # 作品の新規投稿
      new_content(@content_form, @date)
      # ログアウトし、二人目のユーザーを登録
      click_link 'ログアウト'
      new_user(@another_user)
      # 二人目で作品を投稿
      new_content(@another_content, @date)
      # ログアウトし、一人目のユーザーでログインし直す
      click_link 'ログアウト'
      sign_in(@user)
      # 作品の詳細ページへ移動し、投稿したユーザーの詳細ページに移動
      click_link "#{@another_content.title}"
      expect(page).to have_content("【#{@another_content.title}】詳細ページ")
      click_link "#{@another_user.nickname}"
      expect(page).to have_content('ユーザー情報')
      # レコメンドボタンがあることを確認する
      expect(page).to have_content('recommendする')
      # レコメンドボタンをクリックすると作品オススメページに移動する
      click_link 'recommendする'
      expect(page).to have_content('作品オススメページ')
      # 作品リストをクリックすると、現在投稿されている作品がIDとともに表示される
      find('#content-lists').click
      # ID入力欄に作品のIDを入力する
      @content = Content.find_by(title: @content_form.title)
      @id = @content.id
      fill_in 'hidden-id', with: @id
      # レコメンドボタンを押すとモデルのカウントが1上がる
      expect  do
        find('input[name="commit"]').click
      end.to change { Recommend.count }.by(1)
      # オススメしたユーザーの詳細ページに移動したことを確認する
      expect(page).to have_content("#{@another_user.nickname}")
      expect(page).to have_content('ユーザー情報')
      # 詳細ページに自分のオススメが表示されていることを確認する
      expect(page).to have_content("#{@content_form.title}")
      expect(page).to have_content("#{@user.nickname}")
    end
  end
  context '作品をオススメできない時' do
    it '作品のIDが入力されていないとき、オススメできない', js: true do
      # ユーザー新規登録
      new_user(@user)
      # 作品の新規投稿
      new_content(@content_form, @date)
      # ログアウトし、二人目のユーザーを登録
      click_link 'ログアウト'
      new_user(@another_user)
      # 二人目で作品を投稿
      new_content(@another_content, @date)
      # ログアウトし、一人目のユーザーでログインし直す
      click_link 'ログアウト'
      sign_in(@user)
      # 作品の詳細ページへ移動し、投稿したユーザーの詳細ページに移動
      click_link "#{@another_content.title}"
      expect(page).to have_content("【#{@another_content.title}】詳細ページ")
      click_link "#{@another_user.nickname}"
      expect(page).to have_content('ユーザー情報')
      # レコメンドボタンがあることを確認する
      expect(page).to have_content('recommendする')
      # レコメンドボタンをクリックすると作品オススメページに移動する
      click_link 'recommendする'
      expect(page).to have_content('作品オススメページ')
      # 作品リストをクリックすると、現在投稿されている作品がIDとともに表示される
      find('#content-lists').click
      # ID入力欄に作品のIDを入力しない
      fill_in 'hidden-id', with: ''
      # レコメンドボタンを押すとオススメ画面に戻る
      find('input[name="commit"]').click
      expect(page).to have_content('作品オススメページ')
    end
  end
end

RSpec.describe 'オススメ取り消し機能', type: :system do
  before do
    @user = FactoryBot.build(:user)
    @another_user = FactoryBot.build(:user)
    @content_form = FactoryBot.build(:content_form)
    @another_content = FactoryBot.build(:content_form)
    @date = '002000/10/15'
  end
  context 'オススメの取り消しできる時' do
    it '既にオススメしている場合は取り消しができる', js: true do
      # basic認証
      basic_pass root_path
      # ユーザー新規登録
      new_user(@user)
      # 作品の新規投稿
      new_content(@content_form, @date)
      # ログアウトし、二人目のユーザーを登録
      click_link 'ログアウト'
      new_user(@another_user)
      # 二人目で作品を投稿
      new_content(@another_content, @date)
      # ログアウトし、一人目のユーザーでログインし直す
      click_link 'ログアウト'
      sign_in(@user)
      # 作品の詳細ページへ移動し、投稿したユーザーの詳細ページに移動
      click_link "#{@another_content.title}"
      expect(page).to have_content("【#{@another_content.title}】詳細ページ")
      click_link "#{@another_user.nickname}"
      expect(page).to have_content('ユーザー情報')
      # レコメンドボタンがあることを確認する
      expect(page).to have_content('recommendする')
      # レコメンドボタンをクリックすると作品オススメページに移動する
      click_link 'recommendする'
      expect(page).to have_content('作品オススメページ')
      # 作品リストをクリックすると、現在投稿されている作品がIDとともに表示される
      find('#content-lists').click
      # ID入力欄に作品のIDを入力する
      @content = Content.find_by(title: @content_form.title)
      @id = @content.id
      fill_in 'hidden-id', with: @id
      # レコメンドボタンを押すとモデルのカウントが1上がる
      expect  do
        find('input[name="commit"]').click
      end.to change { Recommend.count }.by(1)
      # オススメしたユーザーの詳細ページに移動したことを確認する
      expect(page).to have_content("#{@another_user.nickname}")
      expect(page).to have_content('ユーザー情報')
      # 詳細ページにレコメンド削除のボタンが表示されていることを確認する
      expect(page).to have_content('レコメンドの削除')
      # 削除をクリックすることでモデルのカウントが1下がることを確認
      expect do
        click_link 'レコメンドの削除'
      end.to change { Recommend.count }.by(-1)
      # 詳細ページからオススメした作品の情報が消えていることを確認する
      expect(page).to have_no_content("#{@content_form.title}")
      expect(page).to have_no_content("#{@user.nickname}")
    end
  end
end
