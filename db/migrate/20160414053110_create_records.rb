class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :pet, index: true, foreign_key: true
      t.float :latitude
      t.float :longitude
      t.integer :breathingFrequency
      t.integer :heartFrequency
      t.integer :systolicPressure
      t.integer :distolicPressure
      t.float :temperature

      t.timestamps null: false
    end
  end
end
