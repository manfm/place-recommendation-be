class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.float :latitude
      t.float :longitude
      t.integer :rating

      t.timestamps null: false
    end
  end
end
