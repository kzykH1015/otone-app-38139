class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.string     :title, null: false, unique: true
      t.integer    :category_id, null: false
      t.date       :release_date, null: false
      t.text       :story_line
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
