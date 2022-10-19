module NewUserSupport
  def new_user(user)
    visit new_user_registration_path
    fill_in 'user_nickname', with: @user.nickname
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    fill_in 'user_password_confirmation', with: @user.password_confirmation
    fill_in 'user_self_introduction', with: @user.self_introduction
    find('input[name="commit"]').click
    select '表示しない', from: 'spoiler[genre_spoiler_id]'
    select '表示しない', from: 'spoiler[creator_spoiler_id]'
    select '表示しない', from: 'spoiler[story_line_spoiler_id]'
    select '表示しない', from: 'spoiler[release_date_spoiler_id]'
    select '表示しない', from: 'spoiler[comment_spoiler_id]'
    find('input[name="commit"]').click
    expect(current_path).to eq(spoilers_path)
    click_link "トップへ戻る"
    expect(current_path).to eq(root_path)
  end
end