class CreateSpoilers < ActiveRecord::Migration[6.0]
  def change
    create_table :spoilers do |t|
      t.integer :genre_spoiler_id, null: false
      t.integer :creator_spoiler_id, null: false
      t.integer :story_line_spoiler_id, null: false
      t.integer :release_date_spoiler_id, null: false
      t.integer :comment_spoiler_id, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
