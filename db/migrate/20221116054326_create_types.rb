class CreateTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :types do |t|
      t.string :name
      t.string :description
      t.decimal :price
      t.integer :discount

      t.timestamps
    end
  end
end
