require 'rails_helper'
def basic_pass(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe '作品の編集履歴', type: :system do
  before do
    @user = FactoryBot.build(:user)
    @another_user = FactoryBot.build(:user)
    @content_form = FactoryBot.build(:content_form)
    @date = '002000/10/15'
  end
  context '編集履歴が残る時' do
    it '作品の情報を編集すると編集履歴が残る' do
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
      # 作品の編集ページへ移動する
      click_link '作品の情報を編集する'
      # 編集ページで内容を変更し、更新する
      fill_in 'content_form_title', with: 'superman'
      find('input[name="commit"]').click
      # 作品の詳細ページに更新のログが表示されていること確認する
      expect(page).to have_content("#{@another_user.nickname}がsupermanを編集しました")
    end
  end
end
