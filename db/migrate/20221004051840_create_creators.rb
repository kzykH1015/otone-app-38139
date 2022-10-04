class CreateCreators < ActiveRecord::Migration[6.0]
  def change
    create_table :creators do |t|
      t.string :creator_name, null: false, uniqueness: true
      t.timestamps
    end
  end
end
