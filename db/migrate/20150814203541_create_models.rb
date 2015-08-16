class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :title
      t.integer :price
      t.string :permalink
      t.string :image

      t.timestamps null: false
    end
  end
end
