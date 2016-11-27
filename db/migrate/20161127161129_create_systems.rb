class CreateSystems < ActiveRecord::Migration[5.0]
  def change
    create_table :systems do |t|
      t.string :standard_code, null: false
      t.string :internal_code, null: false
      t.string :particular_name, null: true
      t.integer :x, null: false, default: 0
      t.integer :y, null: false, default: 0
      t.timestamps
    end
    add_index :systems, :particular_name, unique: true
  end
end
