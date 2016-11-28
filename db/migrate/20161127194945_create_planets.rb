class CreatePlanets < ActiveRecord::Migration[5.0]
  def change
    create_table :planets do |t|
      t.integer :star_id, null: false
      t.string :standard_code, null: false
      t.string :internal_code, null: false
      t.string :particular_name
      t.string :position, null: false, default: 'a'
      t.float :star_distance, null: false, default: 1.0
      t.integer :diameter, null: false, default: 12742
      t.float :mass, null: false, default: 1.0
      t.float :orbital_period, null: false, default: 365.25
      t.float :orbital_eccentricity, null: false, default: 0.01
      t.float :rotation_period, null: false, default: 1.0
      t.float :surface_gravity, null: false, default: 1.0
      t.float :surface_pressure, null: false, default: 1.0
      t.integer :surface_temperature, null: false, default: 350
      t.string :surface_type, null: false, default: 't'
      t.float :escape_velocity, null: false, default: 11.15
      t.json :planet_composition
      t.json :atmosphere_composition
      t.text :description
      t.timestamps
    end
    add_index :planets, :particular_name, unique: true
  end
end
