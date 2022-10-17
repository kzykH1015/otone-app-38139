class CreateHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :histories do |t|
      t.integer :content_id, null: false
      t.integer :user_id, null: false
      t.string :message, null: false

      t.timestamps
    end
  end
end
