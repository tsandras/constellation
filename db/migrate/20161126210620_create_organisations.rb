# db/migrate/20161126210620_create_organisations.rb
class CreateOrganisations < ActiveRecord::Migration[5.0]
  def change
    create_table :organisations do |t|
      t.string :name, null: false
      t.text :description, null: true
      t.text :history, null: true
      t.timestamps
    end
    add_index :organisations, :name, unique: true
  end
end
