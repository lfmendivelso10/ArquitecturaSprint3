class CreateSafeZones < ActiveRecord::Migration
  def change
    create_table :safe_zones do |t|
      t.references :pet, index: true, foreign_key: true
      t.decimal :latitude ,precision: 10, scale: 6
      t.decimal :longitude ,precision: 10, scale: 6
      t.float :radius

      t.timestamps null: false
    end
  end
end
