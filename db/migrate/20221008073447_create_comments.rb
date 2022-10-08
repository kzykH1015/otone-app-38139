class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :comment_text, null: false
      t.references :user, null: false
      t.references :content, null: false

      t.timestamps
    end
  end
end
