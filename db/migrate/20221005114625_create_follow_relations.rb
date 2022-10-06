class CreateFollowRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :follow_relations do |t|
      t.integer :follower_id, null: false
      t.integer :followed_id, null: false

      t.timestamps
    end
  end
end
