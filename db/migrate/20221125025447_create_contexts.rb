class CreateContexts < ActiveRecord::Migration[7.0]
  def change
    create_table :contexts do |t|
      t.string :title
      t.text :home
      t.text :about

      t.timestamps
    end
  end
end
