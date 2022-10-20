require 'rails_helper'
def basic_pass(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "コメントの新規投稿", type: :system do
  before do
    @comment = FactoryBot.build(:comment)
    @user = FactoryBot.build(:user)
    @content_form = FactoryBot.build(:content_form)
    @date = "002000/10/15"
  end
  context "コメントを新規投稿できる時" do
    it "正しい情報が揃えばコメントを新規投稿できる" do
      # basic認証
      basic_pass root_path
      # ユーザー新規登録
      new_user(@user)
      # 作品の新規投稿
      new_content(@content_form, @date)
      # 作品の詳細ページへ移動し、それを確認
      click_link "#{@content_form.title}"
      expect(page).to have_content("【#{@content_form.title}】詳細ページ")
      # コメントを入力し投稿すると、非同期通信なのでモデルのカウントが上がらないのを確認する
      fill_in "comment_comment_text", with: @comment.comment_text
      expect do
        find('input[name="commit"]').click
      end.to change { Comment.count }.by(0)
      # 投稿したコメントが表示されていることを確認する
      expect(page).to have_content(@comment.comment_text)
    end
  end
  context "コメントを新規投稿できない時" do
    it "テキストが空だとコメントを投稿できない" do
      # ユーザー新規登録
      new_user(@user)
      # 作品の新規投稿
      new_content(@content_form, @date)
      # 作品の詳細ページへ移動し、それを確認
      click_link "#{@content_form.title}"
      expect(page).to have_content("【#{@content_form.title}】詳細ページ")
      # コメントを空のままコメントするボタンを押しても投稿されない
      find('input[name="commit"]').click
      expect(page).to have_no_content(@comment.comment_text)
    end
  end
end
