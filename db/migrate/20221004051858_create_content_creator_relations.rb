class CreateContentCreatorRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :content_creator_relations do |t|
      t.references :content, foreign_key: true
      t.references :creator, foreign_key: true
      t.timestamps
    end
  end
end
