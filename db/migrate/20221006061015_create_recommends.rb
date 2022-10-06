class CreateRecommends < ActiveRecord::Migration[6.0]
  def change
    create_table :recommends do |t|
      t.references :content, null: false
      t.integer :recommended_id, null: false
      t.integer :recommender_id, null: false

      t.timestamps
    end
  end
end
