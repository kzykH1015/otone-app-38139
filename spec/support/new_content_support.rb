module NewContentSupport
  def new_content(user, content_form, date)
    # 既にログイン状態
    visit root_path
    expect(page).to have_content("作品投稿")
    visit new_content_path
    fill_in 'content_form_title', with: content_form.title
    select 'アニメ', from: 'content_form[category_id]'
    fill_in 'genre-name', with: content_form.genre_name
    fill_in 'creator-name', with: content_form.creator_name
    fill_in 'content_form_story_line', with: content_form.story_line
    fill_in 'content_form_release_date', with: date
    expect{
      find('input[name="commit"]').click
    }.to change { Content.count }.by(1)
    expect(current_path).to eq(root_path)
    expect(page).to have_content(content_form.title)
  end
end