class CreateStars < ActiveRecord::Migration[5.0]
  def change
    create_table :stars do |t|
      t.integer :system_id, null: false
      t.string :standard_code, null: false
      t.string :internal_code, null: false
      t.string :particular_name, null: true
      t.string :position, null: false, default: 'A'
      t.string :spectral_class, null: false
      t.string :spectral_subclass, null: false
      t.string :luminosity_class, null: false
      t.string :prefix, null: true
      t.string :suffix, null: true
      t.integer :rotation, null: false, default: 28
      t.integer :temperature, null: false, default: 5750
      t.float :age, null: false, default: 4.5
      t.float :mass, null: false, default: 1.0
      t.float :rayon, null: false, default: 1.0
      t.text :composition, null: true
      t.text :description, null: true
      t.timestamps
    end
    add_index :stars, :particular_name, unique: true
  end
end