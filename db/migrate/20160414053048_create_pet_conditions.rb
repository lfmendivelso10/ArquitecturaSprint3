class CreatePetConditions < ActiveRecord::Migration
  def change
    create_table :pet_conditions do |t|
      t.references :pet, index: true, foreign_key: true
      t.string :ownerEmail
      t.float :latitude
      t.float :longitude
      t.integer :breathingFrequency
      t.integer :heartFrequency
      t.integer :systolicPressure
      t.integer :distolicPressure
      t.float :temperature

      t.timestamps null: false
    end
    add_index :pet_conditions, :ownerEmail
  end
end
