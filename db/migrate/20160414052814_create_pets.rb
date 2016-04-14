class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :gender, limit: 1
      t.text :description
      t.string :breed
      t.date :birthDate
      t.string :petStatus

      t.timestamps null: false
    end
  end
end
