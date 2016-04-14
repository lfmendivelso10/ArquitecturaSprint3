class CreatePetConditions < ActiveRecord::Migration
  def change
    create_table :pet_conditions do |t|
      t.references :pet, index: true, foreign_key: true
      t.string :ownerEmail
      t.decimal :latitude ,precision: 10, scale: 6
      t.decimal :longitude ,precision: 10, scale: 6
      t.integer :breathingFrequency
      t.integer :heartFrequency
      t.integer :systolicPressure
      t.integer :diastolicPressure
      t.float :temperature

      t.timestamps null: false
    end
    add_index :pet_conditions, :ownerEmail
  end
end
