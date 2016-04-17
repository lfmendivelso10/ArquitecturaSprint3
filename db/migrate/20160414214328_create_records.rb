class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :collarId
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.integer :breathingFrequency
      t.integer :heartFrequency
      t.integer :systolicPressure
      t.integer :diastolicPressure
      t.integer :temperature
      t.string :status

      t.timestamps null: false
    end
    add_index :records, :collarId
  end
end
