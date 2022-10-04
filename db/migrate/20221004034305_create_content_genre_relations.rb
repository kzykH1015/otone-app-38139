class CreateContentGenreRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :content_genre_relations do |t|
      t.references :content, foreign_key: true
      t.references :genre, foreign_key: true
      t.timestamps
    end
  end
end
