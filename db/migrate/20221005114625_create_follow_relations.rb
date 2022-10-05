class CreateFollowRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :follow_relations do |t|
      t.integer :follwer_id, null: false
      t.integer :follwed_id, null: false

      t.timestamps
    end
  end
end
