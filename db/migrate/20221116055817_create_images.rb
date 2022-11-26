class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.string :name
      t.decimal :price
      t.integer :discount
      t.references :anime, null: false, foreign_key: true

      t.timestamps
    end
  end
end
